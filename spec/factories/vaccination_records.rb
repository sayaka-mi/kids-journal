FactoryBot.define do
  factory :vaccination_record do
    child { nil }
    vaccine_id { 1 }
    other_vaccine_name { "MyString" }
    hospital_name { "MyString" }
    memo { "MyText" }
    scheduled_date { "2025-06-25" }
    completed { false }
    vaccinated_at { "2025-06-25" }
  end
end
