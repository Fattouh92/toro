class ModifyChecks < ActiveRecord::Migration
  def change
    create_table :checks do |t|
      t.datetime :datetime
      t.float :pretax
      t.float :taxrate
      t.float :posttax
      t.boolean :current

      t.references :table

      t.timestamps
    end
    add_index :checks, :table_id
  end
end
