require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  let(:user) { create(:user, password: 'password123') } #

  describe 'POST /users/sign_in' do
    it 'signs in successfully with valid credentials' do
      post user_session_path, params: {
        user: { email: user.email, password: 'password123' } #
      }
      expect(response).to redirect_to(root_path) #
    end

    it 'rejects invalid credentials' do
      post user_session_path, params: {
        user: { email: user.email, password: 'wrongpassword' } #
      }
      expect(response).to have_http_status(:unprocessable_content) #
    end
  end
end