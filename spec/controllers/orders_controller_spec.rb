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

  describe "confirm" do
    let(:order) do
      Order.create
    end

    let(:good_params) do
      {
        order: {
          credit_name: "Jenna",
          email: "j@example.com",
          credit_num: "1111111111111111",
          cvv: "111",
          address: "123 Fake St.",
          city: "Anytown",
          state: "WA",
          zip: "12345"
        },
      }
    end
    let(:bad_params) do
      {
        order: {
          credit_name: "Jenna",
        },
      }
    end

    before(:each) do
      session[:order_id] = order.id
      @product = Product.create(name: 'something', price: 200, robot_id: 1, stock: 5)
      @orderitem = Orderitem.create(order_id: order.id, product_id: @product.id, quantity: 2)
    end

    it "redirects to confirmation page when successful" do
      patch :confirm, good_params
      expect(subject).to render_template(:confirm)
    end
    it "reduces stock" do
      patch :confirm, good_params
      expect(Product.find(@product.id).stock).to eq 3
    end
    it "renders checkout page when unsuccessful" do
      patch :confirm, bad_params
      expect(subject).to render_template(:checkout)
    end
  end
end
