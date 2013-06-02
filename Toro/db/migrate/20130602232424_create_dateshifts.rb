class CreateDateshifts < ActiveRecord::Migration
  def change
    create_table :dateshifts do |t|
      t.date :date
      t.integer :shift
      t.timestamps
    end
  end
end
