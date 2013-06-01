class RecreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.decimal :price, :precision => 5, :scale => 2
      t.string :arabicname

      t.references :category

      t.timestamps
    end
    add_index :items, :category_id
  end
end
