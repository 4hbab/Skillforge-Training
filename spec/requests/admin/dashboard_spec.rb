require 'rails_helper'

RSpec.describe "Admin::Dashboards", type: :request do
  let(:admin) { create(:user, :admin) }
  let(:learner) { create(:user, role: :learner) }

  describe "GET /admin/dashboard" do
    context "when logged in as admin" do
      before { sign_in admin }

      it "returns http success" do
        get admin_dashboard_index_path
        expect(response).to have_http_status(:success)
      end
    end

    context "when logged in as non-admin" do
      before { sign_in learner }

      it "redirects to home" do
        get admin_dashboard_index_path
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
