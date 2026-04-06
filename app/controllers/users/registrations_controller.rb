class Users::RegistrationsController < Devise::RegistrationsController
  # Devise uses Strong Parameters to protect against mass-assignment attacks.
  # We override the permitted parameters to include our custom `name` field.
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  private

  # Permit name in addition to email + password during sign-up
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  # Permit name during profile update
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :avatar])
  end
end
