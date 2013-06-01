class Item < ActiveRecord::Base
  attr_accessible :name, :price, :arabicname, :category, :offer
  has_and_belongs_to_many :orders
  belongs_to :category
  validates_uniqueness_of :name
  validates_presence_of :name, :price, :arabicname, :category
  validates_format_of :arabicname, with: /^([\u0621-\u0652 ])+$/
  validates_format_of :price, with: /^[1-9]\d*(\.\d+)?$/
  validates_format_of :offer, with: /^(([1-9]\d*(\.\d+)?)|)$/
  validates_format_of :name, with: /^[a-zA-Z ]*$/
end
