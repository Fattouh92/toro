class AddStatusToTables < ActiveRecord::Migration
  def change
    add_column :tables, :isEmpty, :boolean, :default => true
    add_column :tables, :isFull, :boolean, :default => false
  end
end
