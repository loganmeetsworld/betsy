require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  # describe "GET 'show" do
  #   before :each do
  #     @category = create :category
  #   end

  #   it "returns show page" do
  #     get :show, :id => 1
  #     expect(response).to have_http_status(:success)
  #   end

  #   it "loads the category" do
  #     get :show, :id => 1
  #     expect(assigns(:category)).to eq(@category)
  #   end
  # end
  before :each do
    @category = Category.create(name: 'catprod')
    request.env["HTTP_REFERER"] = "where_i_came_from"
    @current_robot = Robot.create(username: "robo", email: "robo@email.com", password: "BestPosswordOfAll")
    session[:robot_id] = @current_robot.id
  end

  describe "POST 'create'" do
    let(:good_params) do
      {
        category: {
          name: 'catprod',
        }
      }
    end

    let(:bad_params) do
      {
        category: {
          name: ''
        }
      }
    end
    it "renders the new page on failure" do
      post :create, bad_params
      expect(response).to render_template :new
    end

    it "redirects to the referring page on success" do
      post :create, good_params
      expect(response).to redirect_to "where_i_came_from"
      expect(Category.count).to eq 1
    end
  end

  describe "GET 'new'" do
    it "renders the new view" do
      get :new, robot_id: @current_robot
      expect(response).to render_template("new")
    end
  end
end
