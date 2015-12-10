require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe "GET 'index'" do
    it "is successful" do
      get :index
      expect(response.status).to eq 200
      expect(subject).to render_template :index
    end
  end

  describe "GET 'show'" do
    it "renders the show view for a product" do
      get :show, id: product.id
      expect(response.status).to eq 200
      expect(subject).to render_template :show
    end
  end
end
