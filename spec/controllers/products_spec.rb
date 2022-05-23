require 'rails_helper'

RSpec.describe ProductsController, :type => :controller do
    # login_user
    it "renders form" do
        get :new
        expect(subject).to render_template(:new)
    end
    
    it "redirects to signin page" do
      get :home
      expect(response).to redirect_to(new_user_session_path) 
    end
end