class ChangeTypeOfTaxrate < ActiveRecord::Migration
  def change
  	remove_column :checks, :taxrate
  	add_column :checks, :taxrate, :integer, :default => 12
  end
end
