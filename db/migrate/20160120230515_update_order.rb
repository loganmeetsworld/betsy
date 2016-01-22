class UpdateOrder < ActiveRecord::Migration
  def change
    add_column :orders, :name, :string
    add_column :orders, :shipping_carrier, :string
    add_column :orders, :shipping_cost, :integer
    add_column :orders, :billing_address, :string
    add_column :orders, :billing_city, :string
    add_column :orders, :billing_state, :string
    add_column :orders, :billing_zip, :string
  end
end
