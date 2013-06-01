class CreateChecks2 < ActiveRecord::Migration
  def change
    create_table :checks do |t|
      t.datetime :datetime
      t.float :pretax
      t.float :taxrate
      t.float :posttax
      t.boolean :current, :default => true
      t.integer :number_of_customers
      t.float :min_charge
      t.decimal :sum, :precision => 5, :scale => 2

      t.references :table

      t.timestamps
    end
    add_index :checks, :table_id
  end
end
