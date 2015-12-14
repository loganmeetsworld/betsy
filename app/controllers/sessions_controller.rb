class SessionsController < ApplicationController

  def new; end

  def create
    data = params[:session_data]
    @robot = Robot.find_by_email(data[:email])

    if @robot.authenticate(data[:password])
      # robot is authenticated
      session[:robot_id] = @robot.id
      redirect_to robot_path(@robot)
    else
      # robot is not authenticated
      flash.now[:error] = "Something went wrong. Try Again!"
      render :new
    end
  end

  def destroy
    session[:robot_id] = nil
    redirect_to root_url
  end
end
