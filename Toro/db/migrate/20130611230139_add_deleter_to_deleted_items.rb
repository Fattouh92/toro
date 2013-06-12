class AddDeleterToDeletedItems < ActiveRecord::Migration
  def change
  	add_column :deleted_items, :deleter_id, :integer
  	remove_column :checks, :number_of_customers
  	add_column :checks, :number_of_customers, :integer, :default => 1
  end
end
