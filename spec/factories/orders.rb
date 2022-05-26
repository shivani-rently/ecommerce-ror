FactoryBot.define do
    factory :order do
        quantity {Faker::Number.within(range: 1..10)}
        user_id { FactoryBot.create(:user).id }
        product_id {FactoryBot.create(:product).id}
    end
end