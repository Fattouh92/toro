class AddColumnCaptainToUsers < ActiveRecord::Migration
  def change
    add_column :users, :captain, :boolean
  end
end
