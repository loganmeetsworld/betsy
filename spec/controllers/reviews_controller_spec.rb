require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do

  let(:review_params) do
    {
      review: { 
        rating: 3, 
        comment: "comment",
        product_id: 1
      } 
    }
  end

  describe "POST 'create'" do 
    @product = Product.create(name: "hi", price: 100, stock: 2, robot_id: 1)
    @review = { 
        rating: 3, 
        comment: "comment",
        product_id: 1
      } 
    
    it "redirects to product show page" do
        post :create, { product_id: @product.id.to_s, review: @review_params }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(product_path(@product))
    end
  end
end