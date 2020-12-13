FactoryBot.define do
  factory :item do
    name { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
    price { Faker::Number.number(digits: 6) }
    quantity { Faker::Number.number(digits: 2) }
    deadline {Faker::Date.between(from: Date.today, to:1.year.ago )}
    category_id  { Faker::Number.between(from: 2, to: 8) }
    condition_id { Faker::Number.between(from: 2, to: 5) }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/item-sample.png'), filename: 'item-sample.png')
    end
  end
end
