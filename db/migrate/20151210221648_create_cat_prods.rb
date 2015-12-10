class CreateCatProds < ActiveRecord::Migration
  def change
    create_table :cat_prods do |t|

      t.timestamps null: false
    end
  end
end
