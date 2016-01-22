class AddAddressToRobots < ActiveRecord::Migration
  def change
    add_column :robots, :state, :string
    add_column :robots, :city, :string
    add_column :robots, :postal_code, :string
    add_column :robots, :country, :string
  end
end
