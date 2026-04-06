module ApplicationHelper
  def role_badge(user)
    css = case user.role
          when "admin"      then "badge badge-admin"
          when "instructor" then "badge badge-instructor"
          else                   "badge badge-learner"
          end
    content_tag(:span, user.role.humanize, class: css)
  end

  def active_nav(path)
    request.path.start_with?(path) ? "active" : ""
  end

  def page_title(title = nil)
    if title
      content_for(:title) { title }
      title
    elsif content_for?(:title)
      yield(:title)
    else
      "SkillForge"
    end
  end
end
