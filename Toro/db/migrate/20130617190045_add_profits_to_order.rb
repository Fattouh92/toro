class AddProfitsToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :kitchen_profit, :decimal, :default => 0.0
    add_column :orders, :bar_profit, :decimal, :default => 0.0
    add_column :orders, :shisha_profit, :decimal, :default => 0.0
  end
end
