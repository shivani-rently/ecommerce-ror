class FeedbacksController < ApplicationController
    def create
        print "Feedbacks: #{params}"
        @product = Product.find(params["product_id"])
        @feedback = @product.feedbacks.create(comment: params["feedback"]["comment"], user_id: current_user.id)
        flash.notice = "Review Added Successfully"
        redirect_to "/orders"
    end
end
