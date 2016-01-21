class AddDefaultToRobots < ActiveRecord::Migration
  def change
    change_column_default(:robots, :country, "US")
  end
end
