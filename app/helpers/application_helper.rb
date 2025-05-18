module ApplicationHelper
  def page_title(title = "")
    base_title = "V-TACTICS"
    title.present? ? "#{title} | #{base_title}" : base_title
  end

  def default_meta_tags
    {
      site: "V-TACTICS",
      title: "V-TACTICS",
      reverse: true,
      charset: "utf-8",
      description: "各プラットフォームにあるVALORANTのテクニックを簡単に一括検索できるサービス",
      keywords: "ゲーム,valorant,eスポーツ",
      canonical: request.original_url,
      separator: '|',
      icon: [
        { href: image_url("favicon.ico") }
      ],
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.png'),
        local: 'ja-JP',
      },
      twiiter: {
        card: "summary_large_image",
        site: "@",
        image: image_url("ogp.png")
      }
    }
  end
end
