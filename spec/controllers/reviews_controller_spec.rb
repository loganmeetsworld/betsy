require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do

  let(:good_params) { { review: { product_id: 1,rating: 3, comment: "comment" } } }
  let(:bad_params) { { review: { product_id: 1, rating: nil } } }
  let(:product) { { product: { name: 'Test', robot_id: 1, price: 12.34, stock: 2 } } }

  describe "POST 'create'" do 
    context "valid params" do
      it "redirects to product show page after succesfully creating new" do
        post :create, good_params
        expect(subject).to redirect_to product_path(product.id)
      end
    end

    context "invalid params" do
      it "renders new template on error" do
        post :create, bad_params
        expect(subject).to render_template :new
      end
    end
  end

end
