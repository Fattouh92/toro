class AddKakaOh < ActiveRecord::Migration
	def change
		add_column :checks, :cashier_id, :integer
		add_column :checks, :captain_id, :integer
	end
end
