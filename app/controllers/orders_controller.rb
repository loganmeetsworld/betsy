class OrdersController < ApplicationController
  def index
    @order = session[:order]
  end
end
