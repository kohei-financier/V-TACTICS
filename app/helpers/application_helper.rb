module ApplicationHelper
  def page_title(title = "")
    base_title = "V-TACTICS"
    title.present? ? "#{title} | #{base_title}" : base_title
  end
end
