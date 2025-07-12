FactoryBot.define do
  factory :record do
    content { 'MyText' }
    association :child
  end
end
