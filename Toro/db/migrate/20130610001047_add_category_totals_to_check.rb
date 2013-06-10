class AddCategoryTotalsToCheck < ActiveRecord::Migration
  def change
    add_column :checks, :kitchen_profit, :decimal, :default => 0.0
    add_column :checks, :bar_profit, :decimal, :default => 0.0
    add_column :checks, :shisha_profit, :decimal, :default => 0.0
  end
end
