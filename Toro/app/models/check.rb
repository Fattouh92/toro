class Check < ActiveRecord::Base
  attr_accessible :datetime, :taxrate, :current, :number_of_customers, :min_charge, :sum, :table_id, :payment_method, :name
  has_many :orders 
  belongs_to :table
  validates_presence_of :date, :shift, :table_id, :number_of_customers, :captain_id
  def cheques
  	if self.name == nil
  		' ' + Table.find(self.table_id).placement + Table.find(self.table_id).number.to_s
  	else
    ' ' + Table.find(self.table_id).placement + Table.find(self.table_id).number.to_s + ' - ' + self.name
  	end
  end
end
