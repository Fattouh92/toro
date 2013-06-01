class AddOfferColumnToItems < ActiveRecord::Migration
  def change
    add_column :items, :offer, :decimal, :precision => 5, :scale => 2
  end
end
