class AddEmployeeToCheck < ActiveRecord::Migration
  def change
    add_column :checks, :employee, :string
  end
end
