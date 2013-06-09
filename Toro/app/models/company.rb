class Company < ActiveRecord::Base
  has_many :officers
  attr_accessible :name
end
