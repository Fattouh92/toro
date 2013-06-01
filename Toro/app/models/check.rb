class Check < ActiveRecord::Base
  attr_accessible :datetime, :posttax, :pretax, :taxrate, :current
  has_many :items 
  belongs_to :table
end
