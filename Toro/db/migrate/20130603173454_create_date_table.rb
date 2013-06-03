class CreateDateTable < ActiveRecord::Migration
  def up
    create_table :torodates do |t|
      t.date :date
      t.timestamps
    end
  end

  def down
  end
end
