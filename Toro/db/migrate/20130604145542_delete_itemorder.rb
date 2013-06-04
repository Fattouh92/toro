class DeleteItemorder < ActiveRecord::Migration
  def change
  	drop_table :itemorders
  end
end
