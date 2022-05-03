class PhotosController < ApplicationController
    def create
        @product = Product.find(params[:product_id])
        photo_params= params.require(:photo).permit(:image)
        @photo = @product.photos.create(photo_params)
        redirect_to product_path(@product)
    end
end
