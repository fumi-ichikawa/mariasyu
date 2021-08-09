FactoryBot.define do
  factory :mariage do
    title { Faker::Lorem.sentence }
    text { Faker::Lorem.sentence }
    category_id { Faker::Number.between(from: 2, to: 6) }
    taste_id { Faker::Number.between(from: 2, to: 6) }
    
    association :user

    after(:build) do |mariage|
      mariage.image.attach(io: File.open('public/images/test_image.jpg'), filename: 'test_image.jpg')
    end
  end
end
