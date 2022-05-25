FactoryBot.define do
  factory :access_token, class: 'Doorkeeper::AccessToken' do
    application {FactoryBot.create(:application)}
    expires_in { 2.hours }
  end
end