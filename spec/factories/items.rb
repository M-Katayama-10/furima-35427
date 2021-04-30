FactoryBot.define do
  factory :item do
    name                 { Faker::Name.initials(number: 7) }
    description          { 'これは最高級の物です' }
    category_id          { 2 }
    condition_id         { 2 }
    fee_id               { 2 }
    area_id              { 2 }
    days_id              { 2 }
    price                { 50_000 }

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end

    association :user
  end
end
