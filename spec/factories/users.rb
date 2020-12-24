FactoryBot.define do
  factory :user, class: User do |user|
    user.nickname              { Faker::Name.name }
    user.email                 { Faker::Internet.free_email }
    user.sequence(:password)              { |n| "#{n}#{Faker::Internet.password(min_length: 6)}" }
    user.password_confirmation { password }
    user.prefecture_id { Faker::Number.between(from: 2, to: 48) }
    user.phone_number { "0#{rand(0..9)}0#{Faker::Number.number(digits: 8)}" }
    user.contact_email  { Faker::Internet.free_email }
    user.contact_location { Gimei.city.kanji }
  end
end
