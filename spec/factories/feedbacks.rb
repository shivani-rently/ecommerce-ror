FactoryBot.define do
    factory :feedback do
        comment {Faker::Lorem.sentence(word_count: 3) }
        user_id { FactoryBot.create(:user).id }
        product_id {FactoryBot.create(:product).id}
    end
end