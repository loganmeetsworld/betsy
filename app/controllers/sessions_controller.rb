class SessionsController < ApplicationController

  def new; end

  def create
    data = params[:session_data]
    @robot = Robot.find_by_email(data[:email])

    if !@robot.nil?
      # robot is in the system
      if @robot.authenticate(data[:password])
        # robot is authenticated
        session[:robot_id] = @robot.id
        redirect_to root_path
      else
        # robot is not authenticated
        flash.now[:error] = "Try Again!"
        render :new
      end
    else
      # robot is not in the system
      flash[:error] = "Try to Create a New robot"
      redirect_to new_robot_path
    end
  end

  def destroy
    session[:robot_id] = nil
    redirect_to root_url
  end
end
