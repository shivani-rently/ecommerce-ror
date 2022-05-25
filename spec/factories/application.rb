FactoryBot.define do
    factory :application, class: 'Doorkeeper::Application' do
        name {"Test Application"}
    end
end