# spec/support/shoulda_matchers.rb
#
# WHY: Shoulda Matchers provides one-liner helper matchers that replace
# verbose manual test code. For example:
#
#   VERBOSE (without shoulda):
#     it 'validates presence of email' do
#       user = User.new(email: nil)
#       user.valid?
#       expect(user.errors[:email]).to include("can't be blank")
#     end
#
#   CONCISE (with shoulda):
#     it { should validate_presence_of(:email) }
#
# We configure it to work with RSpec and Rails (ActiveRecord + ActionController).

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
