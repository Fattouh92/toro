class CreateOfficers < ActiveRecord::Migration
  def change
    create_table :officers do |t|
      t.string :name
      t.references :company

      t.timestamps
    end
  end
end
