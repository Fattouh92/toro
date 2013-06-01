class AddIndexes < ActiveRecord::Migration
  def up
    add_column :items, :category_id, :integer
    change_column :items, :category_id, :integer, :null => false
  end

  def down
  end
end
