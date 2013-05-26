class Check < ActiveRecord::Base
  attr_accessible :datetime, :posttax, :pretax, :taxrate
  has_many :checks 
  belongs_to :table
end
