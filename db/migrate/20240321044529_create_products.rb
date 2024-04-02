class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :product_name
      t.text :description
      t.float :price
      t.integer :stock_quantity

      t.timestamps
    end
  end
end
