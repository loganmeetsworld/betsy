class OrdersController < ApplicationController
  def index

  end

  def checkout
  end

  def confirm
    @current_order.attributes = order_params
    @current_order.status = "paid"
  end

  def destroy
    @current_order.destroy
    session[:order_id] = nil
    redirect_to orders_path
  end

  private

  def order_params
    params.require(:order).permit([:credit_name, :email, :credit_num, :cvv, :address, :city, :state, :zip])
  end
end
