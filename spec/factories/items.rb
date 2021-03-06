FactoryBot.define do
  factory :item, class: Item do
    name { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
    price { Faker::Number.number(digits: 6) }
    quantity { Faker::Number.number(digits: 2) }
    deadline { Faker::Date.between(from: Date.today, to: 1.year.after) }
    category_id  { Faker::Number.between(from: 2, to: 8) }
    condition_id { Faker::Number.between(from: 2, to: 5) }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    contact_location { Gimei.city.kanji }
    stock { 0 }
    limit { Faker::Date.between(from: Date.today, to: 1.year.after) }

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('app/assets/images/item-sample.png'), filename: 'item-sample.png')
    end
  end
end
