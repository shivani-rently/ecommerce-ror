class Api::OrdersController < Api::ApplicationController
  before_action :current_user

  def index
    begin
      # if !user_signed_in?
      #   render json: {error: "Invalid User"}, status: 400
      # else
        orders = @current_user.orders
        render json: orders, status: 200
      # end
    rescue => exception
      render json: {error: "Something went wrong"}, status: 500
    end
  end
end
