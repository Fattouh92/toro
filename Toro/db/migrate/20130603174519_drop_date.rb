class DropDate < ActiveRecord::Migration
  def up
    drop_table :torodates
  end

  def down
  end
end
