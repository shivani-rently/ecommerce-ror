FactoryBot.define do
    factory :product do
        name {Faker::Lorem.word}
        category {Faker::Lorem.word}
        price {Faker::Number.between(from: 20.0, to: 1000.0)}
        isAvailable {true}
        status {true}
        quantity {Faker::Number.within(range: 1..10)}
        user_id { FactoryBot.create(:user).id }
    end
end