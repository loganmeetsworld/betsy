# require 'pry'
class Order < ActiveRecord::Base
  has_many :orderitems
  validates :name,            presence: true, if: -> { required_for_step?(:shipping_address) }
  validates :address,         presence: true, if: -> { required_for_step?(:shipping_address) }
  validates :city,            presence: true, if: -> { required_for_step?(:shipping_address) }
  validates :state,           presence: true, if: -> { required_for_step?(:shipping_address) }
  validates :zip,             presence: true, numericality: { only_integer: true }, length: { is: 5 },  if: -> { required_for_step?(:shipping_address) }
  validates :shipping_carrier,presence: true, if: -> { required_for_step?(:shipping_info) }
  validates :credit_name,     presence: true, if: -> { required_for_step?(:billing_info) }
  validates :email,           presence: true, if: -> { required_for_step?(:billing_info) }
  validates :credit_num,      presence: true, numericality: { only_integer: true }, length: { is: 16 }, if: -> { required_for_step?(:billing_info) }
  validates :cvv,             presence: true, numericality: { only_integer: true }, length: { is: 3 },  if: -> { required_for_step?(:billing_info) }
  validates :billing_address, presence: true, if: -> { required_for_step?(:billing_info) }
  validates :billing_city,    presence: true, if: -> { required_for_step?(:billing_info) }
  validates :billing_state,   presence: true, if: -> { required_for_step?(:billing_info) }
  validates :billing_zip,      presence: true, numericality: { only_integer: true }, length: { is: 5 },  if: -> { required_for_step?(:billing_info) }

  cattr_accessor :form_steps do
    %w(shipping_address shipping_info billing_info)
  end

  attr_accessor :form_step

  def required_for_step?(step)
    # All fields are required if no form step is present
    return true if form_step.nil?

    # All fields from previous steps are required if the
    # step parameter appears before or we are on the current step
    return true if self.form_steps.index(step.to_s) <= self.form_steps.index(form_step)
  end


  def total_items
    total = 0
    self.orderitems.each do |item|
      total += item.quantity if !item.quantity.nil?
    end
    return total
  end

  def total_amount
    total = 0
    items = self.orderitems

    items.each do |item|
      total += item.product.price * item.quantity
    end
    return total
  end

  # commenting out for now, multistep form should take care of this
  # def awaiting_confirmation?
  #   status == "Awaiting confirmation"
  # end

  def complete?
    complete = true
    a = []
    self.orderitems.each do |item|
      if item.shipped?
        a << true
      else
        a << false
      end
    end

    a.include?(false) ? complete = false : complete = true

    return complete
  end
end
