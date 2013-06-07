class ModifyUsers < ActiveRecord::Migration
  def up
    add_column :users, :accountant, :boolean, :default => false
    add_column :users, :cashier, :boolean, :default => false
    add_column :users, :manager, :boolean, :default => false
    change_column :users, :captain, :boolean, :default => false
  end

  def down
  end
end
