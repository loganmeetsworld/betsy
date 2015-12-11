require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  before :each do
    @product = Product.create(name: 'Test', price: 1, robot_id: 1, stock: 1)
    @category = Category.create(name: 'Catprodlol')
    @product.categories << Category.find(1)

  end

  describe "GET 'index'" do
    it "is successful" do
      get :index
      expect(response.status).to eq 200
      expect(subject).to render_template :index
    end
  end

  describe "GET 'show'" do
    it "renders the show view for a product" do
      get :show, id: @product.id
      expect(response.status).to eq 200
      expect(subject).to render_template :show
    end
  end

  describe  "GET 'category'" do
    it "renders the show view for products of a single category" do
      get :show, id: @category.id
      expect(response.status).to eq 200
      expect(subject).to render_template :category
    end
  end
end
