class ChangeTypeOfMinCharge2 < ActiveRecord::Migration
  def change
  	remove_column :checks, :min_charge
  	add_column :checks, :min_charge, :decimal, :precision => 5, :scale => 2, :default => 0.00
  end
end
