class OrdersController < ApplicationController
  def index

  end

  def checkout
  end

  def confirm
    @current_order.status = "paid"
    @current_order.attributes = order_params
    if !@current_order.save
      @current_order.status = "pending"
      render :checkout
    else
      items = @current_order.orderitems
      items.each do |item|
        item.product.stock -= item.quantity
        item.product.save
      end
      @completed_order = Order.last
      session[:order_id] = nil
    end
  end

  def fulfill
    @robot = Robot.find(params[:id])
    @products = Product.where(robot_id: @robot.id )
  end

  def destroy
    @current_order.destroy
    session[:order_id] = nil
    redirect_to orders_path
  end

  def show
    @guest = Order.find(params[:id])
    @card_num = @guest.credit_num.split(//).last(4).join
  end

  private

  def order_params
    params.require(:order).permit([:credit_name, :email, :credit_num, :cvv, :address, :city, :state, :zip])
  end
end
