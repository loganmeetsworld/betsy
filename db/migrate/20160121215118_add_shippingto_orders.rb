class AddShippingtoOrders < ActiveRecord::Migration
  def change
    add_column :orders, :ship_city, :string
    add_column :orders, :ship_state, :string
    add_column :orders, :ship_zip, :string
  end
end
