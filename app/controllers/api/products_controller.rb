class Api::ProductsController < Api::ApplicationController
  before_action :current_user

  def index
    begin
    if params[:type] == "buy"
      products = Product.where(status: true, isAvailable: true).where.not(user_id: @current_user.id)
      render json: {data: products, status: true}
    elsif params[:type] == "sell"
      products = @current_user.products
      render json: {data: products, status: true}
    else
      render json: {error: "Invalid params", status: false}, status: 400
    end
    rescue => exception
      render json: {error: exception, status: false}, status: 500
    end
  end

  def show
    begin
      product = Product.find(params["id"])
      if product
        render json: {data: product, status: true}, status: 200
      else
        render json: {error: "Invalid product id",status: false}, status: 400
      end
    rescue => exception
      render json: {error: exception, status: false}, status: 500
    end
  end

  def create
    begin
      @product = Product.create(name: params["name"], category: params["category"], price: params["price"], status: true, user_id: @current_user.id, quantity: params["quantity"], isAvailable: true)
      if @product.save
        render json: {status: true}, status: 200
      else 
        render json: {error: "Failed to create product", status: false}, status: 400
      end
    rescue => exception
      render json: {error: exception, status:false}, status: 500
    end
  end

  def update
    begin
    product = Product.find(params[:id])
    if product
      if product.user_id == @current_user.id
        product.update(product_params)
        product.update_attribute(:status, product.quantity > 0)
        render json: {status: true}, status: 200
      else
        render json: {error: "Unauthorized access", status: false}, status: 401
      end
    else
      render json: {error: "Invalid product id", status: false}, status: 400
    end
    rescue => exception
      puts exception
      render json: {error: exception, status: false}, status: 500
    end
  end

  def destroy
    begin
      product = Product.find(params[:id])
      if product
        if product.user_id == @current_user.id
          product.destroy!
          render json: {status: true}, status: 200
        else
          render json: {error: "Unauthorized access", status: false}, status: 401
        end
      else
        render json: {error: "Invalid product id", status: false}, status: 400
      end
    rescue => exception
      render json: {error: exception, status:false}, status: 500
    end
  end

  private
    def product_params
      params.require(:product).permit(:name, :category, :price, :quantity)
    end
end
