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
      @product = Product.create(name: params["product"]["name"], category: params["category"], price: params["product"]["price"], status: true, user_id: current_user.id, quantity: params["product"]["quantity"])
      if @product.save
        puts "Product Created"
        redirect_to '/products?type=sell'
      else 
        render :new
      end
    rescue => exception
      puts "Failed To Created"
      puts exception
      render :new, status: :unprocessable_entity
    end
  end

  def index
    # @products = Product.all
    if params[:type] == "buy"
      @products = Product.where(status: true).where.not(user_id: current_user.id)
    elsif params[:type] == "sell"
      @products = current_user.products.where(user_id: current_user.id)
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def sell_details
    @product = Product.find(params[:id])
  end

  def buy_details
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    puts "Hello" 
    puts params
    @product = Product.find(params[:id])
    if @product.update(name: params["product"]["name"], category: params["category"], price: params["product"]["price"], quantity: params["product"]["quantity"])
      redirect_to "/products/#{@product.id}/sell"
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy! 
    redirect_to '/products?type=sell'
  end

  def buy
    @product = Product.find(params[:id])
    val = current_user.wallet.coins
    if val < @product.price
      redirect_to root_path, notice: "Wallet Doesn't Have Enough Coins"
    else
      buy_product
      create_order_history
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

    def buy_product
      val = current_user.wallet.coins
      current_user.wallet.update_attribute(:coins, val - @product.price)
      @user = User.find_by(id: @product.user_id)
      val = @user.wallet.coins
      @user.wallet.update_attribute(:coins, val + @product.price)
      @product.update_attribute(:quantity, @product.quantity - 1)
      if @product.quantity == 0
        @product.update_attribute(:status, false)
      end
    end

    def create_order_history
      @order = Order.find_by(user_id: current_user.id, product_id: @product.id)
      if @order != nil
        @order.update_attribute(:quantity, @order.quantity + 1)
      else
        @order = Order.create(quantity: 1, user_id: current_user.id, product_id: @product.id)
        @order.save
      end
      redirect_to '/products?type=buy'
    end
end