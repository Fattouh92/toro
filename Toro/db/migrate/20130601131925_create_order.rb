class CreateOrder < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :cashier_name
      t.integer :table_number
      t.string :captain_name
      t.integer :number_of_customers
      t.float :min_charge

      t.references :check

      t.timestamps
    end
    add_index :orders, :check_id
  end
end
