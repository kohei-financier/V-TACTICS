import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="youtube-preview"
export default class extends Controller {

  // HTMLの要素（ターゲット）をココで指定しておく
  static targets = [ "sourceUrl", "timestamp", "preview"]

  update() {
    const url = this.sourceUrlTarget.value;
    const timestamp = this.timestampTarget.value;

    // urlから抜き出したIDを代入
    const videoId = this.youtubeVideoId(url);

    // 秒数に変えた時間を代入
    const startSeconds = this.timestampToSeconds(timestamp);

    if (videoId) {
      const iframe = document.createElement('iframe');
      iframe.setAttribute('src', `https://www.youtube.com/embed/${videoId}?start=${startSeconds}`);
      iframe.setAttribute('frameborder', '0');
      iframe.setAttribute('allow', 'accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture');
      iframe.setAttribute('allowfullscreen', '');
      iframe.className = 'w-full h-full rounded-lg';

      this.previewTarget.innerHTML = '';
      this.previewTarget.appendChild(iframe);

    } else {
      this.previewTarget.innerHTML = '<span class="text-gray-500">投稿前にこちらで動画が確認できます</span>';
    }
  }

  // urlの抜き出しメソッド
  youtubeVideoId(url) {
    // この正規表現はサイトを参考。https://follmy.com/ruby-youtube-embeded/
    const regex = /(?:https:\/\/www\.youtube\.com(?:\/embed\/|\/watch\?v=)|https:\/\/youtu\.be\/)([a-zA-Z0-9_-]{11})/;
    const match = url.match(regex);
    return match ? match[1] : null;
  }

  // 時間を秒数に変えるメソッド
  timestampToSeconds(timestamp) {
    if (!timestamp) return 0;
    const parts = timestamp.split(':').map(Number).reverse();
    let seconds = 0;
    if (parts[0]) seconds += parts[0];
    if (parts[1]) seconds += parts[1] * 60;
    if (parts[2]) seconds += parts[2] * 3600;
    return isNaN(seconds) ? 0 : seconds;
  }
}
