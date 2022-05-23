require 'rails_helper'

RSpec.describe OrdersController, :type => :controller do
    login_user
    describe "GET #index" do
        it "returns a success response" do
            # order = create(:order)
            get :index
            expect(widget).to inc 
        end
    end
end