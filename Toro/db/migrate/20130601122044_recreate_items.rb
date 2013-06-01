class RecreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :type
      t.string :name
      t.float :price

      t.references :check
      t.references :category

      t.timestamps
    end
    add_index :items, :check_id
    add_index :items, :category_id
  end
end
