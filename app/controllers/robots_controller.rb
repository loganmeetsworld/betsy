class RobotsController < ApplicationController
  before_action :require_login, only: [:dashboard]

  def new
    @robot = Robot.new
  end

  def create
    @robot = Robot.new(robot_params)
    if @robot.save
      redirect_to new_session_path
    else
      render "new"
    end
  end

  def show
    @robot = Robot.find(params[:id])
    @products = @robot.products
    # Need to add the 'active' or 'retired' thing
  end

  def dashboard
    @robot = Robot.find(session[:robot_id])
    @products = @robot.products
    @orders = Order.includes(:orderitems).where(orderitems: { robot_id: @robot.id})
  end

  private

  def robot_params
    params.require(:robot).permit(:username, :email, :password, :password_confirmation)
  end
end
