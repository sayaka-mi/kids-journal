FactoryBot.define do
  factory :height_weight do
    association :child
    recorded_on { Date.current }
    height      { 90.0 }
    weight      { 13.4 }

    trait :height_only  do
      weight { nil }
    end

    trait :weight_only  do
      height { nil }
    end
    
    trait :blank do
      height { nil }
      weight { nil }
    end

    trait :negative_height do
      height { -1 }
    end

    trait :negative_weight do
      weight { -2 }
    end
  end
end
