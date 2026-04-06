class ApplicationController < ActionController::Base
  # ─────────────────────────────────────────────────────────────────────────────
  # Pundit Authorization
  # include Pundit::Authorization mixes in:
  #   authorize(@record)        → calls matching policy method (e.g., show?)
  #   policy_scope(Model)       → calls Scope#resolve for scoped queries
  #   policy(@record)           → gives you the policy object (used in views)
  # ─────────────────────────────────────────────────────────────────────────────
  include Pundit::Authorization

  # When a policy method returns false, Pundit raises NotAuthorizedError.
  # We rescue it here globally and redirect with a friendly message.
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

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

  # Pundit NotAuthorizedError handler — called by rescue_from above.
  def user_not_authorized(exception)
    # exception.policy is the policy class that rejected the request
    # exception.query  is the method that failed (e.g., "update?")
    policy_name = exception.policy.class.to_s.underscore
    flash[:alert] = t("pundit.#{policy_name}.#{exception.query}",
                      default: "You are not authorized to perform this action.")
    redirect_back(fallback_location: root_path)
  end
end

