class AddServiceChoice < ActiveRecord::Migration
  def change
    add_column :orders, :ship_choice, :string
    add_column :orders, :ship_price, :integer
  end
end
