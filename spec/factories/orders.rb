FactoryBot.define do
    factory :order do
        quantity {Faker::Number.within(range: 1..10)}
        user_id { 1 }
        product_id {FactoryBot.create(:product).id}
    end
end