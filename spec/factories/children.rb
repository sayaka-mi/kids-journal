FactoryBot.define do
  factory :child do
    name { "太郎" }
    birthday { "2025-06-15" }
    gender { 1 }
    allergy_info { "なし" }
    blood_type { 'A' }
    association :user
  end
end
