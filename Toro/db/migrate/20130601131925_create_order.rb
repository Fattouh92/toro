class CreateOrder < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :cashier_name
      t.string :captain_name
      t.decimal :total, :precision => 5, :scale => 2

      t.references :check

      t.timestamps
    end
    add_index :orders, :check_id
  end
end
