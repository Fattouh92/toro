class Category < ActiveRecord::Base
  attr_accessible :name
  validates_uniqueness_of :name
  validates_presence_of :name, :printer
  has_many :items
  validates :name, :format => { :with => /^[a-zA-Z ]*$/ }
  validates :printer, :format => { :with => /^[1|2|3]$/ }
end
