class AddPrinterToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :printer, :integer
  end
end
