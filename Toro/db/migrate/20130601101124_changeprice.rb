class Changeprice < ActiveRecord::Migration
  def up
    change_column :items, :price, :decimal, :precision => 5, :scale => 2
    remove_column :items, :type
  end

  def down
  end
end
