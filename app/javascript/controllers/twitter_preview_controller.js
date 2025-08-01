import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="twitter-preview"
export default class extends Controller {

  // HTMLの要素（ターゲット）をココで指定する
  static targets = [ "sourceUrl", "titleInput", "categoryInput",
                    "preview", "previewTitle", "previewCategories"]

  connect() {
    this.update()
  }

  update() {
    this.#updatePost()
    this.#updateSelfTitle()
    this.#updateCategories()
  }

  #updatePost() {
    const url = this.sourceUrlTarget.value;

    const postId = url.split('/').pop().split('?')[0];

    if (postId && /^[0-9]+$/.test(postId)) {
      const blockquote = document.createElement('blockquote')
      blockquote.classList.add('twitter-tweet')
      const a = document.createElement('a')
      a.href = `https://twitter.com/user/status/${postId}`
      blockquote.appendChild(a)

      this.previewTarget.innerHTML = ''
      this.previewTarget.appendChild(blockquote)

      if (window.twttr) {
        window.twttr.widgets.load(this.previewTarget)
      } else {
        const script = document.createElement('script')
        script.src = "https://platform.twitter.com/widgets.js"
        script.async = true
        script.charset = "utf-8"
        document.head.appendChild(script)
      }

    } else {
      this.previewTarget.innerHTML = `
        <div class="w-4/5 rounded-lg bg-gray-200 flex items-center justify-center">
          <span class="text-gray-500">URLが正しいかご確認ください。</span>
        </div>`
    }

  }

  #updateSelfTitle() {
    this.previewTitleTarget.textContent = this.titleInputTarget.value || "左の「オリジナルタイトル」のフォームに入力すると、こちらに好きなタイトルを付けることができます！"
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
}
