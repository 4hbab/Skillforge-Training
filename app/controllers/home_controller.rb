class HomeController < ApplicationController
  # Public landing page — no authentication required
  def index
    # If already signed in, redirect to their role-specific dashboard
    if user_signed_in?
      redirect_to after_sign_in_path_for(current_user)
    end
  end
end
