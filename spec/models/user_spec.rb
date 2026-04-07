require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) } #
    it { should validate_presence_of(:name) } #
  end

  describe 'roles' do
    it 'defaults to learner' do
      user = create(:user) #
      expect(user.role).to eq('learner') #
    end

    it 'can be an admin' do
      user = create(:user, :admin) #
      expect(user).to be_admin #
    end
  end
end