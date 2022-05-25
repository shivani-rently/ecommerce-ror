require 'rails_helper'

RSpec.describe FeedbacksController, :type => :controller do
    context "user is authenticated" do
        login_user
        it "creates a new feedback" do
            expect {
            post :create, params: {product_id: create(:product).id, feedback: {comment: "Very nice product"}} 
            }.to change(Feedback, :count).by(1)
      end
    end

      context "user is not authenticated" do
        it "redirects to sign in page" do
            post :create, params: {product_id: create(:product).id, feedback: {comment: "Very nice product"}}
            expect(response).to have_http_status(302)
            expect(response).to redirect_to("/users/sign_in") 
        end
      end
end