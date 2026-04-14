FactoryBot.define do
  factory :course do
    title { "MyString" }
    description { "MyText" }
    difficulty { "MyString" }
    published { false }
    category { nil }
    instructor { nil }
  end
end
