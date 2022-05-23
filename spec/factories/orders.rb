FactoryBot.define do
    factory :order do
        quantity {Faker::Number.number(digits: 1)}
        user_id { 1 }
        product_id {FactoryBot.create(:product).id}
    end
end