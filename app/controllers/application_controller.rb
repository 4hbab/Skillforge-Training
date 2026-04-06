class ApplicationController < ActionController::Base
  # ─────────────────────────────────────────────────────────────────────────────


  # ─────────────────────────────────────────────────────────────────────────────
  # Devise hooks
  # ─────────────────────────────────────────────────────────────────────────────

  # Called after every successful sign-in.
  # We redirect each role to their own dashboard instead of root.
  def after_sign_in_path_for(resource)
    case resource.role
    when "admin"      then admin_dashboard_index_path
    when "instructor" then instructor_dashboard_index_path
    else                   learner_dashboard_index_path
    end
  end

  # Called after sign-out. Send everyone to the homepage.
  def after_sign_out_path_for(_resource_or_scope)
    root_path
  end

  protected

  # Shared helper: redirect unauthorized access with a flash message.
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

  private

end
