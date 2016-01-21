require 'rails_helper'

RSpec::Matchers.define :require_login do

  match do |actual|
    redirect_to Rails.application.routes.url_helpers.login_path
  end

  failure_message do |actual|
    "expected to require login to access the method"
  end

  description do
    "redirect to the login form"
  end

end

RSpec.describe RobotsController, type: :controller do
  let(:robot) { create(:robot) }

  describe "GET 'new'" do
    it "gets new successfully" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "GET 'show'" do
    it "renders the show view for a robot" do
      get :show, id: robot.id
      expect(response.status).to eq 302
    end
  end

  describe 'require login' do
    it "redirects to new session when non-robot tries to go to show" do
      get :show, id: robot.id
      expect(response).to require_login
    end
  end

  describe "POST 'create'" do
    let(:good_params) do
      { robot: attributes_for(:robot)  }
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
      expect(Robot.count).to eq 1
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
