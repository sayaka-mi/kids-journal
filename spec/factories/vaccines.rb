FactoryBot.define do
  factory :vaccine do
    name { "MyString" }
    description { "MyText" }
    min_month { 1 }
    max_month { 12 }
    recommended_doses { 1 }
    dose_months { [2] }
    optional { false }
  end
end
