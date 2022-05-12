class Api::LikesController < ApplicationController

  def index
    begin
      likes = current_user.likes
      render json: likes, status: 200
    rescue => exception
      render json: {error: "Error fetching details"}
    end
  end

  def create
    begin
        like = Like.create(user_id: current_user.id, product_id: params[:id])
        if like.save
          render json: like, status: 200 
        end
    rescue => exception
      puts exception
      render json: {error: "Something went wrong"}, status: 500
    end
  end

  def show
    product = Product.find(params[:id])
    likes = product.liked_users
    render json: likes, status: 200
  end

  def destroy
    begin
      like = Like.find_by(product_id: params[:id], user_id: current_user.id)
      like.destroy!
      render json: {status: "true"},status: 200
    rescue => exception
      puts exception
      render json: {error: "Something went wrong"}, status: 500
    end
  end

end
