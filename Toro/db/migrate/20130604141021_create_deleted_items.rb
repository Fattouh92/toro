class CreateDeletedItems < ActiveRecord::Migration
  def change
    create_table :deleted_items do |t|
      t.integer :item_id
      t.integer :order_id
      t.integer :check_id

      t.timestamps
    end
  end
end
