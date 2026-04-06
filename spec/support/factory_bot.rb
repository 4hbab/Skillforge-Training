# spec/support/factory_bot.rb
#
# WHY: FactoryBot is a library for creating test objects (fixtures replacement).
# Instead of User.create(email: "...", password: "...", ...) everywhere,
# you write: create(:user) — and the factory fills in the rest.
#
# This config file includes FactoryBot::Syntax::Methods globally so you can
# call: create(:user), build(:user), attributes_for(:user) in any spec
# without the FactoryBot:: prefix.

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
