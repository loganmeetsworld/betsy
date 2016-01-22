require 'rails_helper'

RSpec.describe CheckoutController, type: :controller do
  describe "GET 'show'" do
    let(:params) do
      {
        id: "shipping_info",
      }
    end

    it "renders the shipping_info page when customer is on shipping_info step" do
      get :show, params
      expect(response).to render_template(:shipping_info)
    end
  end

  describe "PUT 'update'" do
    let(:order_params1) do
      {
        order: {
          shipping_cost: 40,
        },
        id: "shipping_info"
      }
    end

    let(:order_params2) do
      {
        order: {
          name: "Brittany",
          address: "my house",
          city: "Seattle",
          state: "WA",
          zip: "12345"
        },
        id: "shipping_address"
      }
    end

    let(:order_params3) do
      {
        order: {
          credit_name: "Brittany",
          email: "b@b.com",
          credit_num: "1234567812345678",
          cvv: "123",
          billing_address: "here",
          billing_city: "Seattle",
          billing_state: "WA",
          billing_zip: "12345"
        },
        id: "billing_info"
      }
    end

    # Need to investigate further how the wicked gem works
    it "renders the shipping_info page when customer is on shipping_info step" do
      put :update, order_params1
      expect(response).to render_template(:shipping_info)
    end

    it "renders the billing_info page when customer is on billing_info step" do
      put :update, order_params3
      expect(response).to render_template(:billing_info)
    end

    it "renders nothing when customer is on shipping_address step" do
      put :update, order_params2
      expect(response).to render_template()
    end
  end

  describe "finish_wizard_path" do

  end
end
