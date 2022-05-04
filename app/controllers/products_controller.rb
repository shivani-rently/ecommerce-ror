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
      @product = Product.create(name: params["product"]["name"], category: params["product"]["category"], price: params["product"]["price"], status: true, user_id: current_user.id)
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
    else
      @user = current_user
      @products = @user.products
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      redirect_to "/products/#{@product.id}"
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
      current_user.wallet.update_attribute(:coins, val - @product.price)
      @user = User.find_by(id: @product.user_id)
      val = @user.wallet.coins
      @user.wallet.update_attribute(:coins, val + @product.price)
      @product.update_attribute(:status, false)
      redirect_to '/products?type=buy'
    end
  end

  private
    def product_params
      params.require(:product).permit(:name, :category, :price)
    end

    def check_user
      if !user_signed_in?
        redirect_to new_user_session_path
      end
    end
end
