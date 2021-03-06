class Api::OrdersController < Api::ApplicationController
  before_action :current_user

  def index
    begin
      orders = Order.find_by(user_id: @current_user.id)
      render json: {data: orders, status: true}, status: 200
    rescue => exception
      render json: {error: exception, status: false}, status: 500
    end
  end
end
