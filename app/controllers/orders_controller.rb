class OrdersController < ApplicationController
  def index
  end

  def order_checkout
    redirect_to checkout_path(Order.form_steps.first)
  end

  def shipping
  end

  def billing
  end

  def confirm
    @completed_order = @current_order
    @current_order.status = "Awaiting confirmation"
  end

  def cancel
    @current_order.status = "cancelled"
    @current_order.save
    session[:order_id] = nil
    redirect_to orders_path
  end

  def finalize
    items = @current_order.orderitems
    items.each do |item|
      if item.quantity > item.product.stock
        flash[:error] = "Oh no! Too slow. You may need to adjust the quantity of items in your cart."
        redirect_to orders_path and return
      else
        item.product.stock -= item.quantity
        item.product.save
      end
    end
    @current_order.status = "paid"
    @current_order.purchase_time = Time.now
    @current_order.save
    session[:order_id] = nil
    render :thanks
  end

  def fulfill
    @items = current_robot.orderitems
    @order = @current_order
  end

  def destroy
    @current_order.destroy
    session[:order_id] = nil
    redirect_to orders_path
  end

  def info
    @guest = Order.find(params[:id])
    @card_num = @guest.credit_num.split(//).last(4).join
  end

  private

  def order_params
    params.require(:order).permit([:credit_name, :email, :credit_num, :cvv, :address, :city, :state, :zip, :name, :shipping_carrier, :shipping_cost, :billing_address, :billing_city, :billing_state, :billing_zip])
  end
end
