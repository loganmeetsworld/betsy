class CheckoutController < ApplicationController
  include Wicked::Wizard
  steps *Order.form_steps

  def show
    if params[:id] == "shipping_info"
      order = @current_order
      @ups_rates = ShippingService::Order.new(order).get_total("ups")
      @fedex_rates = ShippingService::Order.new(order).get_total("fedex")
    end
    render_wizard
  end

  def update
    @current_order.update(order_params(step))
    render_wizard @current_order
  end

  def finish_wizard_path
    confirm_path
  end

  private

  def order_params(step)
    permitted_attributes = case step
    when "shipping_address"
        [:name, :address, :city, :state, :zip]
    when "shipping_info"
      [:shipping_carrier]
    when "billing_info"
      [:credit_name, :email, :credit_num, :cvv, :billing_address, :billing_city, :billing_state, :billing_zip]
    end

    params.require(:order).permit(permitted_attributes).merge(form_step: step)
  end
end
