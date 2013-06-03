class RopDate < ActiveRecord::Migration
  def up
    drop_table :dates
  end

  def down
  end
end
