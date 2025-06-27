FactoryBot.define do
  factory :vaccine do
    name { "MyString" }
    description { "MyText" }
    min_month { 1 }
    max_month { 1 }
    optional { false }
  end
end
