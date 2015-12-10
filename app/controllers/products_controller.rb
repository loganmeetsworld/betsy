class ProductsController < ApplicationController

before_action only: [:show, :edit, :update] { @product = Product.find(params[:id]) }

  def index
    @products = Product.order(stock: :desc)
  end

  def show
    @review = Review.new(product_id: @product.id)
    @order_item = Orderitem.new(order_id: @current_order.id, product_id: @product.id)
  end

  private

  def product_params
    params.require(:product).permit([:name, :description, :price, :robot_id, :categories, :picture_url, :stock])
  end
end
