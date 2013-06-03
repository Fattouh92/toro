class RemoveKakaHassan < ActiveRecord::Migration
	def change
		remove_column :checks, :pretax
		remove_column :checks, :posttax
		remove_column :checks, :employee

		remove_column :orders, :captain_name
		remove_column :orders, :cashier_name 
	end
end
