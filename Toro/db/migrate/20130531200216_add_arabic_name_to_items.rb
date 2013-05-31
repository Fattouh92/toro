class AddArabicNameToItems < ActiveRecord::Migration
  def change
    add_column :items, :arabicname, :string
  end
end
