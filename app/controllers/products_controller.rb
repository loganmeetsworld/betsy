class ProductsController < ApplicationController

before_action only: [:show, :edit, :update] { @product = Product.find(params[:id]) }

  def index
    @products = Product.order(stock: :desc)
  end

  def show
    @review = Review.new(product_id: @product.id)
    if @current_order.orderitems.where("product_id = ?", params[:id]).first
      @order_item = @current_order.orderitems.where("product_id = ?", params[:id]).first
    else
      @order_item = Orderitem.new(product_id: @product.id)
    end
  end

  private

  def product_params
    params.require(:product).permit([:name, :description, :price, :robot_id, :categories, :picture_url, :stock])
  end
end
