require 'rails_helper'

RSpec.describe "Likes", :type => :request do
 context 'when unauthorized' do
    it 'fails with HTTP 401' do
      get "/api/likes"
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context 'when authorized' do
    let(:application) { FactoryBot.create(:application) }
    let(:user)        { FactoryBot.create(:user) }
    let(:token)       { FactoryBot.create(:access_token, application: application, resource_owner_id: user.id) }

    it "returns list of products liked by users" do
        like = create(:like, user_id: user.id)
        get "/api/likes", params: {}, headers: { 'Authorization': 'Bearer ' + token.token }
        res = JSON.parse(response.body)
        expect(response).to have_http_status(200)
        expect(res["data"]).to match([JSON.parse(like.to_json)])
    end

    it "returns list of liked users of a product" do
        product = create(:product)
        like = create(:like, product_id: product.id, user_id: user.id)
        get "/api/likes/#{product.id}", params: {}, headers: { 'Authorization': 'Bearer ' + token.token }
        res = JSON.parse(response.body)
        expect(response).to have_http_status(200)
        expect(res["data"]).to match([JSON.parse(user.to_json)])
    end

    it "adds product to user's favorite" do
        product = create(:product)
        expect{ post "/api/likes", params: {id: product.id},
         headers: { 'Authorization': 'Bearer ' + token.token }}.to change(Like, :count).by(+1)
        expect(response).to have_http_status(200)
    end

    it "returns error if product already added to favorites" do
      product = create(:product)
      like = create(:like, product_id: product.id, user_id: user.id)
      post "/api/likes", params: {id: product.id}, headers: { 'Authorization': 'Bearer ' + token.token }
      expect(response).to have_http_status(400)
    end

    it "removes product from user favorites" do
        product = create(:product)
        like = create(:like, product_id: product.id, user_id: user.id)
        delete "/api/likes/#{product.id}", params: {}, headers: { 'Authorization': 'Bearer ' + token.token }
        expect(response).to have_http_status(200)
    end
  end
end