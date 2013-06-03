class AddNameToCheck < ActiveRecord::Migration
  def change
  	add_column :checks, :name, :string
  end
end
