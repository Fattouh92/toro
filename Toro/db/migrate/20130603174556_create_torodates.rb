class CreateTorodates < ActiveRecord::Migration
  def change
    create_table :torodates do |t|
      t.date :date
      t.timestamps
    end
  end
end
