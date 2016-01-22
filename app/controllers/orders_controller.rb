class OrdersController < ApplicationController
  def index

  end

  def checkout
  end

  def confirm
    @completed_order = @current_order
    @current_order.status = "Awaiting confirmation"
    @current_order.attributes = order_params
    if !@current_order.save
      @current_order.status = "pending"
      render :checkout
    end
    ups = @current_order.get_ups
    usps = @current_order.get_usps
    @rates = ups + usps
    cookies.signed[:shipping] = @rates
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

    ship_hash = cookies.signed[:shipping][params[:order][:ship_choice].to_i]
    @current_order.ship_choice = ship_hash["rate"]
    @current_order.ship_price = ship_hash["price"]
    @current_order.status = "paid"
    @current_order.purchase_time = Time.now
    @current_order.save
    @total_price = @current_order.total_ship
    session[:order_id] = nil
    cookies.delete :shipping
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
    params.require(:order).permit([:credit_name, :email, :credit_num, :cvv, :address, :city, :state, :zip, :ship_city, :ship_zip, :ship_state])
  end
end
