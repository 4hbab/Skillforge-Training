module ApplicationHelper
  def active_nav(path)
    current_page?(path) ? "active" : ""
  end
end
