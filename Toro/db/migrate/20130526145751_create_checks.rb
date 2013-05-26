class CreateChecks < ActiveRecord::Migration
  def change
    create_table :checks do |t|
      t.datetime :datetime
      t.float :pretax
      t.float :taxrate
      t.float :posttax

      t.timestamps
    end
  end
end
