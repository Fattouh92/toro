class Category < ActiveRecord::Base
  attr_accessible :name
  validates_uniqueness_of :name
  validates_presence_of :name
  has_many :items
  validates :name, :format => { :with => /^[a-zA-Z ]*$/ }
end
