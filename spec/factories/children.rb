FactoryBot.define do
  factory :child do
    name { "MyString" }
    birthday { "2025-06-15" }
    gender { 1 }
    allergy_info { "MyText" }
    blood_type { "MyString" }
    user { nil }
  end
end
