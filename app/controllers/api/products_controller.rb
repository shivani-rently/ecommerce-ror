class Api::ProductsController < ApplicationController
  def index
    begin
    if params[:type] == "buy"
      products = Product.where(status: true, isAvailable: true).where.not(user_id: params[:userid])
    elsif params[:type] == "sell"
      user = User.find(params[:userid])
      products = user.products.where(user_id: user.id)
    end
      render json: {data: products, status: true}
    rescue => exception
      puts exception
      render json: {error: "Something went wrong", status: false}, status: 500
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
      puts exception
      render json: {error: "Something went wrong", status: false}, status: 500
    end
  end

  def create
    begin
      @product = Product.create(name: params["name"], category: params["category"], price: params["price"], status: true, user_id: params["userid"], quantity: params["quantity"], isAvailable: true)
      if @product.save
        render json: {status: true}, status: 200
      else 
        render json: {error: "Failed to create product", status: false}, status: 400
      end
    rescue => exception
      puts exception
      render json: {error: "Something went wrong", status:false}, status: 500
    end
  end

  def update
    begin
    product = Product.find(params[:id])
    if product
      puts "1"
      product.update(product_params)
      puts "2"
      product.update_attribute(:status, product.quantity > 0)
      puts "3"
      render json: {status: true}, status: 200
    else
      render json: {error: "Invalid product id"}, status: 400
    end
    rescue => exception
      puts exception
      render json: {error: "Something went wrong", status:false}, status: 500
    end
  end

  def destroy
    begin
      product = Product.find(params[:id])
      if product
        product.destroy!
        render json: {status: true}, status: 200
      else
        render json: {error: "Invalid product id", status: false}, status: 400
      end
    rescue => exception
      puts exception
      render json: {error: "Something went wrong", status:false}, status: 500
    end
  end

  private
    def product_params
      params.require(:product).permit(:name, :category, :price, :quantity)
    end
end
