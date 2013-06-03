class Check < ActiveRecord::Base
  attr_accessible :datetime, :taxrate, :current, :number_of_customers, :min_charge, :sum, :table_id, :payment_method, :name
  has_many :orders 
  belongs_to :table
  validates_presence_of :date, :shift
end
