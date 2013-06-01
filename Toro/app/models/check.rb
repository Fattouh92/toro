class Check < ActiveRecord::Base
  attr_accessible :datetime, :posttax, :pretax, :taxrate, :current
  has_many :orders 
  belongs_to :table
end
