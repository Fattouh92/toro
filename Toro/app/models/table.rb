class Table < ActiveRecord::Base
  attr_accessible :number
  validates_presence_of :number
  has_many :checks

  def self.create_table(number, placement)
    table = where(number: number, placement: placement).first_or_create
    if table.save 
      [true, table]
    else
      [false, table]
    end
  end

  def self.delete_table(number, placement)
    table = Table.where(number: number, placement: placement).first
    table.delete
  end
  
end
