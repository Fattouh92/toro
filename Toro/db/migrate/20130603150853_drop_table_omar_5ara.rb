class DropTableOmar5ara < ActiveRecord::Migration
  def up
    drop_table :items_orders
  end

  def down
  end
end
