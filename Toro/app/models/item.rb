class Item < ActiveRecord::Base
  attr_accessible :name, :price, :type, :arabicname
  belongs_to :check
  validates_uniqueness_of :name
  validates_presence_of :name, :price, :type, :arabicname
end
