class CreateVisas < ActiveRecord::Migration
  def change
    create_table :visas do |t|
      t.string :bankname

      t.timestamps
    end
  end
end
