FactoryBot.define do
  factory :vaccination_record do
    association :child
    association :vaccine

    vaccinated_at { nil }
    other_vaccine_name { nil }
    hospital_name { "MyString" }
    memo { "MyText" }
  end
end
