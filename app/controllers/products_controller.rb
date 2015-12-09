class ProductsController < ApplicationController

before_action only: [:show, :edit, :update] { @product = Product.find(params[:id]) }

  def index
    @products = Product.order(stock: :desc)
  end

  def show
    
  end
end
