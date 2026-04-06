# spec/requests/authentication_spec.rb
#
# REQUEST SPECS are integration tests — they send real HTTP requests through
# the full Rails stack (router → controller → model → response).
# They test your application from the outside, like a browser would.
#
# Devise provides test helpers via `include Devise::Test::IntegrationHelpers`
# which gives us `sign_in(user)` for authenticated specs.

require "rails_helper"

RSpec.describe "Authentication", type: :request do
  # ─────────────────────────────────────────────────────────────────────────────
  # Sign Up (Registration)
  # ─────────────────────────────────────────────────────────────────────────────
  describe "POST /users (Sign Up)" do
    context "with valid credentials" do
      it "creates a new user and redirects" do
        expect {
          post user_registration_path, params: {
            user: {
              name:                  "Test User",
              email:                 "test@example.com",
              password:              "password123",
              password_confirmation: "password123"
            }
          }
        }.to change(User, :count).by(1)

        # After sign-up, Devise redirects to root or the after_sign_up_path
        expect(response).to have_http_status(:see_other).or have_http_status(:redirect)
      end

      it "assigns learner role by default" do
        post user_registration_path, params: {
          user: {
            name:                  "New Learner",
            email:                 "learner@example.com",
            password:              "password123",
            password_confirmation: "password123"
          }
        }
        new_user = User.find_by(email: "learner@example.com")
        expect(new_user).to be_learner
      end
    end

    context "with invalid credentials" do
      it "does not create a user without a name" do
        expect {
          post user_registration_path, params: {
            user: {
              name:                  "",
              email:                 "noname@example.com",
              password:              "password123",
              password_confirmation: "password123"
            }
          }
        }.not_to change(User, :count)

        expect(response).to have_http_status(:unprocessable_content)
      end

      it "does not create a user with mismatched passwords" do
        expect {
          post user_registration_path, params: {
            user: {
              name:                  "Test",
              email:                 "mismatch@example.com",
              password:              "password123",
              password_confirmation: "different"
            }
          }
        }.not_to change(User, :count)
      end
    end
  end

  # ─────────────────────────────────────────────────────────────────────────────
  # Sign In (Session)
  # ─────────────────────────────────────────────────────────────────────────────
  describe "POST /users/sign_in" do
    # let(:user) uses lazy evaluation — the user is only created when referenced.
    # It's memoized: the same user object is used throughout the example.
    let(:learner)    { create(:user, email: "learner@test.com", password: "password123") }
    let(:admin)      { create(:user, :admin, email: "admin@test.com", password: "password123") }
    let(:instructor) { create(:user, :instructor, email: "instr@test.com", password: "password123") }

    it "signs in with valid credentials" do
      post user_session_path, params: {
        user: { email: learner.email, password: "password123" }
      }
      expect(response).to redirect_to(learner_dashboard_index_path)
    end

    it "redirects admin to admin dashboard" do
      post user_session_path, params: {
        user: { email: admin.email, password: "password123" }
      }
      expect(response).to redirect_to(admin_dashboard_index_path)
    end

    it "redirects instructor to instructor dashboard" do
      post user_session_path, params: {
        user: { email: instructor.email, password: "password123" }
      }
      expect(response).to redirect_to(instructor_dashboard_index_path)
    end

    it "rejects invalid password" do
      post user_session_path, params: {
        user: { email: learner.email, password: "wrongpassword" }
      }
      expect(response).to have_http_status(:unprocessable_content)
    end
  end

  # ─────────────────────────────────────────────────────────────────────────────
  # Authorization Guards
  # ─────────────────────────────────────────────────────────────────────────────
  describe "Protected routes" do
    it "redirects unauthenticated users away from the admin dashboard" do
      # GET /admin/dashboard without signing in
      get admin_dashboard_index_path
      # Devise redirects to sign-in page
      expect(response).to redirect_to(new_user_session_path)
    end

    it "redirects learners away from the admin dashboard" do
      learner = create(:user)
      # sign_in is a Devise test helper — it bypasses the sign-in form
      sign_in learner
      get admin_dashboard_index_path
      expect(response).to redirect_to(root_path)
    end

    it "allows admins to access the admin dashboard" do
      admin = create(:user, :admin)
      sign_in admin
      get admin_dashboard_index_path
      expect(response).to have_http_status(:ok)
    end
  end
end
