class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  def after_sign_in_path_for(resource)
    case resource.role
    when "admin"      then admin_dashboard_index_path
    when "instructor" then instructor_dashboard_index_path
    else                   learner_dashboard_index_path
    end
  end

  def after_sign_out_path_for(_resource_or_scope)
    root_path
  end

  protected

  def require_admin!
    unless current_user&.admin?
      redirect_to root_path, alert: "You are not authorized to access that page."
    end
  end

  def require_instructor!
    unless current_user&.instructor? || current_user&.admin?
      redirect_to root_path, alert: "You are not authorized to access that page."
    end
  end
end
