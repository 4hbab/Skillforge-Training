# spec/factories/users.rb
#
# WHY FACTORIES?
# Factories are blueprints for creating test data. Instead of manually
# specifying every attribute in every test, you call:
#   create(:user)           => creates a learner with fake name/email
#   create(:user, :admin)   => creates an admin using the :admin trait
#   build(:user)            => instantiates but does NOT save to DB (faster)
#   attributes_for(:user)   => returns a hash of attributes (useful for params)
#
# Faker generates realistic-looking fake data so test output is readable.

FactoryBot.define do
  factory :user do
    # Faker::Name.name generates names like "Jane Smith", "Bob Martinez"
    name  { Faker::Name.name }
    # unique.email prevents duplicates across test data (email has UNIQUE index)
    email { Faker::Internet.unique.email }
    password              { "password123" }
    password_confirmation { "password123" }
    # Default role is learner (matching the model's default: :learner)
    role { :learner }

    # ── Traits ──────────────────────────────────────────────────────────────
    # Traits are named overrides. Usage: create(:user, :admin)
    # They override only the specified attributes, inheriting everything else.

    trait :admin do
      role { :admin }
      name { "Admin #{Faker::Name.last_name}" }
    end

    trait :instructor do
      role { :instructor }
      name { "Prof. #{Faker::Name.last_name}" }
    end

    trait :learner do
      role { :learner }
    end
  end
end
