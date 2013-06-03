class Check < ActiveRecord::Base
  attr_accessible :datetime, :taxrate, :current, :number_of_customers, :min_charge, :sum, :table_id, :payment_method, :name
  has_many :orders 
  belongs_to :table
  validates_presence_of :date, :shift, :number_of_customers, :name, :captain_id, :taxrate, :min_charge, :table_id
end
