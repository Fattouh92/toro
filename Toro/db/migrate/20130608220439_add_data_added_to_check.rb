class AddDataAddedToCheck < ActiveRecord::Migration
  def change
  	add_column :checks, :dataAdded, :boolean, :default => false
  end
end
