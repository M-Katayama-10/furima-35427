FactoryBot.define do
  factory :purchase_address do
    postal_code { '123-4567' }
    area_id { 6 }
    municipality { '湘南' }
    house_number { '98-56' }
    phone_number { '09876543211' }
    token {"tok_abcdefghijk99999999999999"}
  end
end
