module ApplicationHelper
  def full_title page_title = ""
    base_title = t "base_title"
    page_title.present? ? "#{page_title} | #{base_title}" : base_title
  end
end
