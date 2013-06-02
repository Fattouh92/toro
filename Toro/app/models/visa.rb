class Visa < ActiveRecord::Base
  attr_accessible :bankname
  validates_uniqueness_of :bankname
  validates_presence_of :bankname
  validates :bankname, :format => { :with => /^[a-zA-Z ]*$/ }
end
