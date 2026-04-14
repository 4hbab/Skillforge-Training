require 'rails_helper'

RSpec.describe "Homes", type: :request do
  describe "GET /" do
    it "returns http success for non-logged in users" do
      get root_path
      expect(response).to have_http_status(:success)
    end

    context "when logged in as admin" do
      let(:admin) { create(:user, :admin) }
      before { sign_in admin }

      it "redirects to admin dashboard" do
        get root_path
        expect(response).to redirect_to(admin_dashboard_index_path)
      end
    end

    context "when logged in as instructor" do
      let(:instructor) { create(:user, :instructor) }
      before { sign_in instructor }

      it "redirects to instructor dashboard" do
        get root_path
        expect(response).to redirect_to(instructor_dashboard_index_path)
      end
    end

    context "when logged in as learner" do
      let(:learner) { create(:user, role: :learner) }
      before { sign_in learner }

      it "redirects to learner dashboard" do
        get root_path
        expect(response).to redirect_to(learner_dashboard_index_path)
      end
    end
  end
end
