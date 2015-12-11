class SessionsController < ApplicationController
  resources :sessions, :only => [:new, :create]
  def new; end

  def create
    robot = Robot.authenticate(params[:email], params[:password])
    if robot
      session[:robot_id] = robot.id
      redirect_to robot_path(robot.id)
    else
      flash.now[:error]= "Try Again!"
      render :new
    end
  end

  def destroy
    session[:robot_id] = nil
    redirect_to root_url
  end
end
