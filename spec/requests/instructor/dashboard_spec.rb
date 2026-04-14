require 'rails_helper'

RSpec.describe "Instructor::Dashboards", type: :request do
  let(:instructor) { create(:user, :instructor) }
  let(:learner) { create(:user, role: :learner) }

  describe "GET /instructor/dashboard" do
    context "when logged in as instructor" do
      before { sign_in instructor }

      it "returns http success" do
        get instructor_dashboard_index_path
        expect(response).to have_http_status(:success)
      end
    end

    context "when logged in as learner" do
      before { sign_in learner }

      it "redirects to home" do
        get instructor_dashboard_index_path
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
