FactoryBot.define do
  factory :user do
    name { Faker::Name.name } #
    email { Faker::Internet.unique.email } #
    password { 'password123' } #
    role { :learner } #

    trait :admin do
      role { :admin } #
    end

    trait :instructor do
      role { :instructor } #
    end
  end
end