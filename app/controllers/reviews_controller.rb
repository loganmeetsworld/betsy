class ReviewsController < ApplicationController

  # def new
  #   @review = Review.new
  # end

  def create
    @review = Review.create(review_params)
    redirect_to :back
  end

  private

  def review_params
    params.require(:review).permit(:product_id, :rating, :comment)

  end
end
