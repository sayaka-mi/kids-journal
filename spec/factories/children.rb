FactoryBot.define do
  factory :child do
    name { "太郎" }
    birthday { Date.new(2025, 6, 17) }
    gender { Child.genders.keys.sample }
    allergy_info { "なし" }
    blood_type { Child.blood_types.keys.sample }
    association :user
  end
end
