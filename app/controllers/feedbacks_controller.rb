class FeedbacksController < ApplicationController
    def create
        @product = Product.find(params[:id])
        @feedback = @product.feedbacks.create(comment: params["comment"], user_id: current_user.id)
    end
end
