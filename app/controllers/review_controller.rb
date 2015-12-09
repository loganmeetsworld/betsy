class ReviewController < ApplicationController

  def new
    @review = Review.new
  end

  def update
    @review.update(review_params[:review])
  end

  private

  def review_params
    params.permit(review: [:product_id, :rating, :comment])

  end
end
