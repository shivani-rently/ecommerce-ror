class Api::LikesController < Api::ApplicationController
  before_action :current_user

  def index
    begin
      likes = @current_user.likes
      render json: {data: likes, status: true}, status: 200
    rescue => exception
      render json: {error: exception, status: false}, status: 500
    end
  end

  def create
    begin
      like = Like.find_by(product_id: params[:id], user_id: @current_user.id)
      if like == nil
        like = Like.create(user_id: @current_user.id, product_id: params[:id])
        if like.save
          render json: {data: like, status: true}, status: 200 
        end
      else
        render json: {error: "Product already added to favourites", status: false}, status: 400
      end
    rescue => exception
      render json: {error: exception, status: false}, status: 500
    end
  end

  def show
    begin
    product = Product.find(params[:id])
    likes = product.liked_users
    render json: {data: likes, count: likes.count, status: true}, status: 200
    rescue => exception
      render json: {error: exception, status: false}, status: 500
    end
  end

  def destroy
    begin
      like = Like.find_by(product_id: params[:id], user_id: @current_user.id)
      like.destroy!
      render json: {status: true}, status: 200
    rescue => exception
      render json: {error: exception, status: false}, status: 500
    end
  end

end
