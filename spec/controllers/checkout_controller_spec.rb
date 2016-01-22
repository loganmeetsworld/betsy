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
    
  end

end
