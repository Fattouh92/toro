class Check < ActiveRecord::Base
  attr_accessible :datetime, :posttax, :pretax, :taxrate, :current, :number_of_customers, :min_charge, :sum
  has_many :orders 
  belongs_to :table
  validates_presence_of :date, :shift, :employee
end
