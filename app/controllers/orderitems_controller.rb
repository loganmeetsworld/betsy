class OrderitemsController < ApplicationController
  def add_to_cart
    if order_item = @current_order.orderitems.where("product_id = ?", order_item_params[:product_id]).first  # the order already contains this product
      order_item.increment(:quantity, by: order_item_params[:quantity])
      flash.now[:success] = "The quantity of this product has been updated in your cart"
    else # the current order doesn't have this product yet
      order_item = OrderItem.new(order_item_params)
      @current_order.orderitems.push(order_item)
      flash.now[:success] = "This product has been added to your cart"
    end
  end

  def change_quantity

  end

  private

  def order_item_params
    params.require(:order_item).permit([:product_id, :quantity])
  end


end
