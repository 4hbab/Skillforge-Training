require 'rails_helper'

RSpec.describe "Learner::Dashboards", type: :request do
  let(:learner) { create(:user, role: :learner) }

  describe "GET /learner/dashboard" do
    context "when logged in as learner" do
      before { sign_in learner }

      it "returns http success" do
        get learner_dashboard_index_path
        expect(response).to have_http_status(:success)
      end
    end

    context "when not logged in" do
      it "redirects to sign in" do
        get learner_dashboard_index_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
