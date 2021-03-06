FactoryBot.define do
    factory :user do
        email {Faker::Internet.email}
        name {"Test user"}
        mobile {Faker::Number.number(digits:10)}
        password {"Test@123"}
        password_confirmation {"Test@123"}
    end
end