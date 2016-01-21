require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:robot) { create(:robot) }

  describe "POST 'create'" do
    let (:session_data) do
      {
        email: robot.email,
        password: robot.password
      }
    end

    let (:bad_params) do
      {
        session_data:{
          email: "bad@robot.com",
          password: "password"
        }
      }
    end

    it "creates a session and redirects to robot account page" do
      post :create, :session_data => session_data
      expect(response).to redirect_to robot_path(robot)
    end

    it "renders new template on error" do
      post :create, bad_params
      expect(subject).to render_template :new
    end
  end

  describe "DELETE 'destroy" do
    it "allows robot to log out and destroys session" do
      session[:robot_id] = robot.id
      delete :destroy
      expect(session[:robot_id]).to eq(nil)
    end
  end
end
