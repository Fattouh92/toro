class OrdersItems < ActiveRecord::Migration
  def change
    create_table :orders_items do |t|
      t.references :order
      t.references :item
    end
  end
end
