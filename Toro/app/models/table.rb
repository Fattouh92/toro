class Table < ActiveRecord::Base
  attr_accessible :number
  validates_uniqueness_of :number
  validates_presence_of :number
  has_many :checks

  def self.create_table(number)
    table = where(number: number).first_or_create
    if table.save 
      [true, table]
    else
      [false, table]
    end
  end

  def self.delete_table(table_id)
    table = Table.where(id: table_id).first
    table.delete
  end
  
end