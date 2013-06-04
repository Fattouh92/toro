class CreateItemorders < ActiveRecord::Migration
  def change
    create_table :itemorders do |t|
      t.integer :item_id
      t.integer :order_id
      t.integer :quantity

      t.timestamps
    end
  end
end
