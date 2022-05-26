FactoryBot.define do
    factory :like do
        user_id { FactoryBot.create(:user).id }
        product_id {FactoryBot.create(:product).id}
    end
end