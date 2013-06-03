class AddItemOrders2 < ActiveRecord::Migration
  def up
    drop_table :item_orders
    create_table :item_orders do |t|
      t.integer :item_id
      t.integer :order_id
      t.integer :quantity
    end
  end

  def down
  end
end
