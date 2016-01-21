require 'rails_helper'

RSpec.describe OrderitemsController, type: :controller do
  let(:orderitem) { create(:orderitem) }
  let(:order) { orderitem.order }
  let(:product) { orderitem.product }
  let(:good_params) do
    {
      orderitem: {
        quantity: 5
      },
      id: product.id
    }
  end
  describe "POST 'add_to_cart'" do
    it "redirects to show view" do
      post :add_to_cart, good_params
      expect(subject).to redirect_to product_path(product.id)
    end
  end

  describe "PATCH 'add_to_cart'" do
    it "redirects to show view" do
      post :add_to_cart, good_params
      patch :add_to_cart, good_params
      expect(subject).to redirect_to product_path(product.id)
    end
  end

  describe "PATCH 'increase_quantity'" do
    before(:each) do
      request.env["HTTP_REFERER"] = "where_i_came_from"
      session[:order_id] = order.id
    end

    it "refreshes the page on success" do
      patch :increase_quantity, id: product.id
      expect(subject).to redirect_to "where_i_came_from"
    end

    it "refreshes the page on failure" do
      patch :increase_quantity, id: product.id
      patch :increase_quantity, id: product.id
      patch :increase_quantity, id: product.id
      expect(subject).to redirect_to "where_i_came_from"
    end
  end

  describe "PATCH 'decrease_quantity'" do
    before(:each) do
      request.env["HTTP_REFERER"] = "where_i_came_from"
      session[:order_id] = order.id
    end

    it "refreshes the page on success" do
      patch :decrease_quantity, id: product.id
      expect(subject).to redirect_to "where_i_came_from"
    end

    it "refreshes the page on failure" do
      patch :decrease_quantity, id: product.id
      patch :decrease_quantity, id: product.id
      patch :decrease_quantity, id: product.id
      expect(subject).to redirect_to "where_i_came_from"
    end
  end

  describe "DELETE 'remove'" do
    before(:each) do
      request.env["HTTP_REFERER"] = "where_i_came_from"
      session[:order_id] = order.id
    end

    it "refreshes the page" do
      delete :remove, id: product.id
      expect(subject).to redirect_to "where_i_came_from"
    end
  end

  describe "GET 'ship'" do
    before(:each) do
      request.env["HTTP_REFERER"] = "where_i_came_from"
    end

    it "reverses the shipped status" do
      patch :ship, id: orderitem.id
      expect(orderitem.shipped).to eq false
    end
  end
end
