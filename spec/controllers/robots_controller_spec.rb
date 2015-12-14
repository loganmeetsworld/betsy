require 'rails_helper'

RSpec.describe RobotsController, type: :controller do

  describe "GET 'new'" do 
    it "gets new successfully" do 
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "GET 'show'" do
    Robot.create(email: "testy@test.com", username: "testytest", password_digest: "test")
    it "renders the show view for a robot" do
      get :show, id: 1
      expect(response.status).to eq 200
    end
  end

  describe "POST 'create'" do 
    let(:good_params) do 
      {
        robot: {
          username: 'name_2',
          email: 'robot2@robot2.com',
          password: 'test',
          password_confirmation: 'test'
        }
      }
    end

    let(:bad_params) do 
      {
        robot: {
          username: 'name_2',
          password: 'test',
          password_confirmation: 'test'
        }
      }
    end

    it "creates robot" do 
      post :create, good_params 
      expect(Robot.count).to eq 2
    end

    it "redirects to login page" do 
      post :create, good_params
      expect(subject).to redirect_to new_session_path
    end

    it "renders new with bad params" do 
      post :create, bad_params
      expect(subject).to render_template(:new)
    end
  end
end
