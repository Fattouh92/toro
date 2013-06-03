class AddItemOrders < ActiveRecord::Migration
  def up
    create_table :item_orders do |t|
      t.references :item
      t.references :order
    end
  end

  def down
  end
end
