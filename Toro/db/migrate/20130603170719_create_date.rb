class CreateDate < ActiveRecord::Migration
  def up
    create_table :dates do |t|
      t.date :date
      t.timestamps
    end
  end

  def down
  end
end
