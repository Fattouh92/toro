class AddPayedToCheck < ActiveRecord::Migration
  def change
    add_column :checks, :payed, :float
  end
end
