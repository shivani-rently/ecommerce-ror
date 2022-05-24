require 'rails_helper'

RSpec.describe OrdersController, :type => :controller do
    describe "user is authenticated" do
    login_user
        it "displays list of orders" do
            order = create(:order, user_id: @user_id)
            get :index
            expect(response).to have_http_status(:ok)
            expect(assigns(:orders)).to eq([order])
        end
    end

    describe "user is not authenticated" do
        it "redirects to sign in page" do
            get :index
            expect(response).to have_http_status(302)
            expect(response).to redirect_to("/users/sign_in") 
        end
    end
end