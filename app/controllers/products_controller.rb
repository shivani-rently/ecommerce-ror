class ProductsController < ApplicationController
  def home
  end

  def new
    @product = Product.new
  end

  def create
    begin
      @product = Product.new(name: params["product"]["name"], category: params["product"]["category"], price: params["product"]["price"])
      if @product.save
        puts "Product Created"
        redirect_to '/products'
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
    @products = Product.all
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

    redirect_to '/products'
  end

  private
    def product_params
      params.require(:product).permit(:name, :category, :price)
    end

end
