FactoryBot.define do
  factory :transaction do
    invoice { nil }
    credit_card_number { "1111000022223333" }
    credit_card_expiration_date { "2018-11-26" }
    result { "MyString" }
  end
end
