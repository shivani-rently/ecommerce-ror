require 'rails_helper'

RSpec.describe OrdersController, :type => :request do
 context 'when unauthorized' do
    it 'fails with HTTP 401' do
      get "/api/orders"
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when authorized' do
    let(:application) { FactoryBot.create(:application) }
    let(:user)        { FactoryBot.create(:user) }
    let(:token)       { FactoryBot.create(:access_token, application: application, resource_owner_id: user.id) }

    it 'returns the list of orders' do
        order = create(:order, user_id: user.id)
        get "/api/orders", params: {}, headers: { 'Authorization': 'Bearer ' + token.token }
        res = JSON.parse(response.body)
        expect(response).to have_http_status(200)
        expect(res["data"]).to match(JSON.parse(order.to_json))
    end
  end
end