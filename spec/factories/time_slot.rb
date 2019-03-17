FactoryBot.define do
  factory :time_slot do
    description "Default TimeSlot"
    association :shop, factory: :shop, strategy: :build
  end
end
