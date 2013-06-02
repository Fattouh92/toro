class AddDateAndShiftToCheck < ActiveRecord::Migration
  def change
    add_column :checks, :date, :date
    add_column :checks, :shift, :integer
  end
end
