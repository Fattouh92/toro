class AddTableIdToCheck < ActiveRecord::Migration
  def change
  	add_column :checks, :table_id, :integer
  end
end
