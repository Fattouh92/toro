class ChangeTypeOfMinCharge < ActiveRecord::Migration
  def change
  	remove_column :checks, :min_charge
  	add_column :checks, :min_charge, :decimal, :precision => 5, :scale => 2
  end
end
