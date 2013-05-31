class AddPlacmentToTables < ActiveRecord::Migration
  def change
    add_column :tables, :placement, :string
  end
end
