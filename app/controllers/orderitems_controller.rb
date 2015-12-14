class OrderitemsController < ApplicationController
  def add_to_cart
    if @current_order.orderitems.where("product_id = ?", params[:id]).first
      @order_item = @current_order.orderitems.where("product_id = ?", params[:id]).first
    else
      @order_item = Orderitem.new(product_id: params[:id])
    end
    @order_item.increment(:quantity, order_item_params[:quantity].to_i)
    if @order_item.order_id.nil?
      @current_order.orderitems.push(@order_item)
    end
    @order_item.save
    flash[:success] = "You've updated your cart."
    redirect_to product_path(params[:id])
  end

  def increase_quantity
    @order_item = @current_order.orderitems.where("product_id = ?", params[:id]).first
    @order_item.increment!(:quantity)
    redirect_to :back
  end

  def decrease_quantity
    @order_item = @current_order.orderitems.where("product_id = ?", params[:id]).first
    @order_item.decrement!(:quantity)
    redirect_to :back
  end

  private

  def order_item_params
    params.require(:orderitem).permit([:product_id, :quantity])
  end


end
