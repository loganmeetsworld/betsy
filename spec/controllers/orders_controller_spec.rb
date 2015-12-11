require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  describe "GET 'index'" do
    it "is successful" do
      get :index
      expect(response.status).to eq 200
    end
  end

  describe "DELETE 'destroy'" do
    it "redirects to index view" do
      delete :destroy, id: good_art.id
      expect(subject).to redirect_to polymorphic_path(model)
    end
  end
end
