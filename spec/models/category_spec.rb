require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'validations' do
    subject { create(:category) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:description) }
  end
end
