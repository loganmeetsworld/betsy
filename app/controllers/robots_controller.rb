class RobotsController < ApplicationController
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
  
  end

  private

  def robot_params
    params.require(:robot).permit(:username, :email, :password, :salt, :encrypted_password)
  end
end
