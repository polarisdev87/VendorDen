FactoryBot.define do
  factory :vendor do
    business_name 'Exeter Studios LLC'
    association :shop, factory: :shop, strategy: :build
    email 'jonathan@exeter.com'
    poc_first_name 'Jonathan'
    poc_last_name 'MacAllister'
    phone_number '+459395516299'
    tax_id '12-45678'
  end
end
