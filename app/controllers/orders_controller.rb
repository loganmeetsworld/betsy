class OrdersController < ApplicationController
  def index

  end

  def destroy
    @current_order.destroy
    session[:order_id] = nil
    redirect_to orders_path
  end
end
