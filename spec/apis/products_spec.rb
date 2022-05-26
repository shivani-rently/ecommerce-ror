require 'rails_helper'

RSpec.describe "Products", :type => :request do
 context 'when unauthorized' do
    it 'fails with HTTP 401' do
      get "/api/products"
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when authorized' do
    let(:application) { FactoryBot.create(:application) }
    let(:user)        { FactoryBot.create(:user) }
    let(:token)       { FactoryBot.create(:access_token, application: application, resource_owner_id: user.id) }

    it "returns products list available for sale" do
        product = create(:product)
        get "/api/products", params: {type: "buy"}, headers: {'Authorization': 'Bearer ' + token.token}
        res = JSON.parse(response.body)
        expect(response).to have_http_status(200)
        expect(res["data"]).to match([JSON.parse(product.to_json)])
    end

    it "returns products sold by user" do
        product = create(:product, user_id: user.id)
        get "/api/products", params: {type: "sell"}, headers: {'Authorization': 'Bearer ' + token.token}
        res = JSON.parse(response.body)
        expect(response).to have_http_status(200)
        expect(res["data"]).to match([JSON.parse(product.to_json)])
    end

    it "returns 400 error if type not provided" do
        get "/api/products", params: {}, headers: {'Authorization': 'Bearer ' + token.token}
        expect(response).to have_http_status(400)
    end

    it "returns a product's details" do
        product = create(:product)
        get "/api/products/#{product.id}", params: {}, headers: {'Authorization': 'Bearer ' + token.token}
        res = JSON.parse(response.body)
        expect(response).to have_http_status(200)
        expect(res["data"]).to match(JSON.parse(product.to_json))
    end

    it "returns 500 for invalid product id" do
        get "/api/products/100", params: {}, headers: {'Authorization': 'Bearer ' + token.token}
        expect(response).to have_http_status(500)
    end

    it "creates a new product"
  end
end