class FeedbacksController < ApplicationController
    before_action :check_user
    def create
        print "Feedbacks: #{params}"
        @product = Product.find(params["product_id"])
        @feedback = @product.feedbacks.create(comment: params["feedback"]["comment"], user_id: current_user.id)
        flash.notice = "Review Added Successfully"
        redirect_to "/orders"
    end

    private
    def check_user
      if !user_signed_in?
        redirect_to new_user_session_path
      end
    end
end
