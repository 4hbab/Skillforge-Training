require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(2).is_at_most(50) }
    it { should validate_presence_of(:email) }
  end

  describe "role enum" do
    it "defaults to learner when no role is specified" do
      user = build(:user)
      expect(user.role).to eq("learner")
    end

    it "can be set to admin" do
      user = create(:user, :admin)
      expect(user).to be_admin
      expect(user).not_to be_learner
    end

    it "can be set to instructor" do
      user = create(:user, :instructor)
      expect(user).to be_instructor
    end

    it "provides scopes for each role" do
      admin      = create(:user, :admin)
      instructor = create(:user, :instructor)
      learner    = create(:user)

      expect(User.admins).to      include(admin)
      expect(User.instructors).to include(instructor)
      expect(User.learners).to    include(learner)
    end
  end

  describe "#display_name" do
    it "returns the user's name when present" do
      user = build(:user, name: "Jane Smith")
      expect(user.display_name).to eq("Jane Smith")
    end
  end

  describe "#role_label" do
    it "returns a humanized role string" do
      admin = build(:user, :admin)
      expect(admin.role_label).to eq("Admin")
    end
  end

  describe "persistence" do
    it "saves a valid user to the database" do
      user = create(:user)
      expect(User.find(user.id)).to eq(user)
    end

    it "does not save a user without a name" do
      user = build(:user, name: "")
      expect(user).not_to be_valid
      expect(user.errors[:name]).to be_present
    end
  end
end
