require 'rails_helper'

RSpec.describe ProductsController, :type => :controller do
  subject {
    create(:product)
  }

    describe "if user is not authenticated then" do
      it "redirects to signin page" do
        get :home
        expect(response).to have_http_status(302)
        expect(response).to redirect_to("/users/sign_in") 
      end
    end

    describe "if user is authenticated then" do
      login_user
      it "renders home view" do
        get :home
        expect(response).to render_template(:home) 
      end

      it "renders form to create product" do
          get :new
          expect(response).to render_template(:new)
      end

      it "creates new product" do
        expect {
            post :create, params: {category: "Women Accessories", product: {name: "Earrings", price: 50.0, quantity: 2}} 
            }.to change(Product, :count).by(1)
      end

      it "lists products created by current user" do
        product = create(:product, user_id: @user_id)
        get :sell_list
        expect(assigns(:products)).to eq([product])
      end

      it "shows product details created by current user" do
        product = create(:product, user_id: @user_id)
        get :sell_details, params: {id: product.id}
        assigns(:product).should eq(product)
      end

      it "lists products available for sale" do
        get :index
        expect(assigns(:products)).to eq([subject])
      end

      it "shows product details avaiable for sale" do
        product = create(:product)
        get :buy_details, params: {id: product.id}
        assigns(:product).should eq(product)
      end

      it "renders edit form" do
        get :edit, params: {id: subject.id}
        expect(response).to render_template(:edit)
        assigns(:product).should eq(subject)
      end

      it "updates product details" do
        put :update, params: {id: subject.id, product: {price: 70.0}}
        assigns(:product).price.should eq 70.0
      end
    end
end