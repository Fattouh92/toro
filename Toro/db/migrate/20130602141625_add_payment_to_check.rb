class AddPaymentToCheck < ActiveRecord::Migration
  def change
  	add_column :checks, :payment_method, :string
  end
end
