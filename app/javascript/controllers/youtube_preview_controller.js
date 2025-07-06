import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="youtube-preview"
export default class extends Controller {

  // HTMLの要素（ターゲット）をココで指定しておく
  static targets = [ "sourceUrl", "timestamp","titleInput", "categoryInput", //input系
                    "preview", "previewTitle", "previewOriginalTitle", "previewCategories" //モックアップに書く
                    ]

  connect() {
    this.update()
  }

  update() {
    this.#updateVideo()
    this.#updateSelfTitle()
    this.#updateOriginalTitle()
    this.#updateCategories()
  }

  #updateVideo() {
    const url = this.sourceUrlTarget.value;
    const timestamp = this.timestampTarget.value;

    // urlから抜き出したIDを代入
    const videoId = this.#youtubeVideoId(url);

    // 秒数に変えた時間を代入
    const startSeconds = this.#timestampToSeconds(timestamp);

    if (videoId) {
      const iframe = document.createElement('iframe');
      iframe.setAttribute('src', `https://www.youtube.com/embed/${videoId}?start=${startSeconds}`);
      iframe.setAttribute('frameborder', '0');
      iframe.setAttribute('allow', 'accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture');
      iframe.setAttribute('allowfullscreen', '');
      iframe.className = 'w-full h-full';

      this.previewTarget.innerHTML = '';
      this.previewTarget.appendChild(iframe);

    } else {
      this.previewTarget.innerHTML = '<span class="text-gray-500">投稿前にこちらで動画が確認できます</span>';
    }
  }

  // urlの抜き出しメソッド
  #youtubeVideoId(url) {
    // この正規表現はサイトを参考。https://follmy.com/ruby-youtube-embeded/
    const regex = /(?:https:\/\/www\.youtube\.com(?:\/embed\/|\/watch\?v=)|https:\/\/youtu\.be\/)([a-zA-Z0-9_-]{11})/;
    const match = url.match(regex);
    return match ? match[1] : null;
  }

  // 時間を秒数に変えるメソッド
  #timestampToSeconds(timestamp) {
    if (!timestamp) return 0;
    const parts = timestamp.split(':').map(Number).reverse();
    let seconds = 0;
    if (parts[0]) seconds += parts[0];
    if (parts[1]) seconds += parts[1] * 60;
    if (parts[2]) seconds += parts[2] * 3600;
    return isNaN(seconds) ? 0 : seconds;
  }

  #updateSelfTitle() {
    this.previewTitleTarget.textContent = this.titleInputTarget.value || "左の「オリジナルタイトル」のフォームに入力すると、こちらに好きなタイトルを付けることができます！"
  }

  #updateOriginalTitle() {
    const url = this.sourceUrlTarget.value
    const videoId = this.#youtubeVideoId(url)

    if (videoId) {
      // デフォルトの表示（まだフォームにURLが入っていない時）
      this.previewOriginalTitleTarget.textContent = "元動画：タイトルを取得中・・・。"
      this.#fetchVideoTitle(videoId)
    } else {
      this.previewOriginalTitleTarget.textContent = "元動画：（ここに自動で動画タイトルが表示されます）"
    }
  }

  #updateCategories() {
    this.previewCategoriesTarget.innerHTML = ''
    const categoryNames = this.categoryInputTarget.value

    if (categoryNames) {
      const categories = categoryNames.split(',').map(name => name.trim()).filter(name => name)
      categories.forEach(name => {
        const badge = document.createElement('span')
        badge.className = 'badge badge-outline badge-primary'
        badge.textContent = name
        this.previewCategoriesTarget.appendChild(badge)
      })
    }
  }

  async #fetchVideoTitle(videoId) {
    try {
      const response = await fetch(`/youtube/title?video_id=${videoId}`)
      if (!response.ok) {
        throw new Error('YouTube APIからの応答がありませんでした。')
      }
      const data = await response.json()

      if (data.title) {
        this.previewOriginalTitleTarget.textContent = `元動画：${data.title}`
      } else {
        throw new Error('JSONにタイトルが含まれていません。')
      }
    } catch (error) {
      console.error("動画タイトルの取得に失敗しました:", error)
      this.previewOriginalTitleTarget.textContent = "元動画：タイトルの取得に失敗しました"
    }
  }

}
