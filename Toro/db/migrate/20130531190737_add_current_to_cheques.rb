class AddCurrentToCheques < ActiveRecord::Migration
  def change
  	add_column :checks, :current, :boolean, :default => true
  end
end
