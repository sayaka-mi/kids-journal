FactoryBot.define do
  factory :child do
    name { "太郎" }
    birthday { Date.new(2025, 6, 17) }
    gender { 1 }
    allergy_info { "なし" }
    blood_type { 'A' }
    association :user
  end
end
