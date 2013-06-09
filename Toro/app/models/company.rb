class Company < ActiveRecord::Base
  has_many :officers
  attr_accessible :name
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_format_of :name, with: /^[a-zA-Z ]*$/
end
