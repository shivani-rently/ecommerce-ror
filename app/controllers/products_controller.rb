class ProductsController < ApplicationController
  before_action :check_user, on: [:new, :index, :edit, :destroy, :buy]

  def home
    if user_signed_in?
      @wallet = current_user.wallet
    end
  end

  def new
    @product = Product.new
  end

  def create
    begin
      @product = Product.create(name: params["product"]["name"], category: params["category"], price: params["product"]["price"], status: true, user_id: current_user.id, quantity: params["product"]["quantity"], isAvailable: true)
      if @product.save
        redirect_to '/products/sell'
      else 
        render :new
      end
    rescue => exception
      puts exception
      render :new, status: :unprocessable_entity
    end
  end

  def index
    puts params
    @products = Product.where(status: true, isAvailable: true).where.not(user_id: current_user.id)
    if params.has_key?(:category)
      @products = @products.filter_by_category(params[:category])
    end
    if params.has_key?(:price)
      @products = @products.filter_by_price(params[:price])
    end
  end

  def sell_list
    @products = current_user.products.where(user_id: current_user.id).where(isAvailable: true)
  end

  def show
    @product = Product.find(params[:id])
  end

  def sell_details
    @product = Product.find(params[:id])
  end

  def buy_details
    @product = Product.find(params[:id])
    @like = current_user.likes.where(product_id: @product.id)
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(name: params["product"]["name"], category: params["category"], price: params["product"]["price"], quantity: params["product"]["quantity"], status: params["product"]["quantity"].to_i > 0)
      redirect_to "/products/#{@product.id}/sell"
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.update_attribute(:isAvailable, false)
    # @product.destroy! 
    redirect_to '/products/sell'
  end

  def buy
    quantity = params["quantity"]
    @product = Product.find(params[:id])
    if quantity == ""
      flash.alert = "Quantity Cannot Be Empty"
      redirect_to "/products/#{@product.id}/buy"
    elsif quantity.to_i == 0
      flash.alert = "Invalid quantity"
      redirect_to "/products/#{@product.id}/buy"
    elsif quantity.to_i > @product.quantity
      flash.alert = "Required Quantity Not Available"
      redirect_to "/products/#{@product.id}/buy"
    else
      val = current_user.wallet.coins * quantity.to_f
      if val < @product.price
        flash.alert = "Wallet Doesn't Have Enough Coins"
        redirect_to "/products/#{@product.id}/buy"
      else
        buy_product quantity
        create_order_history quantity
      end
    end
  end

  private
    def product_params
      params.permit(:name, :category, :price, :quantity)
    end

    def check_user
      if !user_signed_in?
        redirect_to new_user_session_path
      end
    end

    def buy_product(quantity)
      val = current_user.wallet.coins
      price = @product.price * quantity.to_i
      current_user.wallet.update_attribute(:coins, val - price)
      @user = User.find_by(id: @product.user_id)
      val = @user.wallet.coins
      @user.wallet.update_attribute(:coins, val + price)
      @product.update_attribute(:quantity, @product.quantity - quantity.to_i)
      if @product.quantity == 0
        @product.update_attribute(:status, false)
      end
    end

    def create_order_history(quantity)
      @order = Order.find_by(user_id: current_user.id, product_id: @product.id)
      if @order != nil
        @order.update_attribute(:quantity, @order.quantity + quantity.to_i)
      else
        print @order.methods
        @order = Order.create(quantity: 1, user_id: current_user.id, product_id: @product.id)
        @order.save
      end
        redirect_to '/products?type=buy'
    end
end