class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :current_order
  before_action :find_categories
  before_action :find_robots

  def find_categories
    @categories = Category.all
  end

  def find_robots
    @robots = Robot.all
  end

  def current_robot
    @robot = nil
  end
  
  def current_order
    return @current_order if @current_order
    if session[:order_id]
      @current_order = Order.find(session[:order_id])
    else
      @current_order = Order.create(status: "pending")
      session[:order_id] = @current_order.id
    end

  end
end
