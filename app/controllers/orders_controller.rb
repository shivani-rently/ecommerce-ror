class OrdersController < ApplicationController
  before_action :check_user

  def index
    @orders = current_user.orders
  end

  private
    def check_user
      if !user_signed_in?
        redirect_to new_user_session_path
      end
    end  
end
