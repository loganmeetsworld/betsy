require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  describe "GET 'index'" do
    it "is successful" do
      get :index
      expect(response.status).to eq 200
    end
  end

  describe "DELETE 'destroy'" do
    let(:order) do
      Order.create(status: "pending")
    end

    before(:each) do
      session[:order_id] = order.id
    end

    it "redirects to index view" do
      delete :destroy, id: order.id
      expect(subject).to redirect_to orders_path
    end
  end

  describe "GET 'show'" do
    it "is successful" do
      get :show
      expect(response.status).to eq 200
    end
  end

  describe "GET 'fulfill'" do
    it "is successful" do
      get :fulfill
      expect(response.status).to eq 200
    end
  end
end
