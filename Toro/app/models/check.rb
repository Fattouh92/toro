class Check < ActiveRecord::Base
  attr_accessible :datetime, :posttax, :pretax, :taxrate, :current
  has_many :items 
  belongs_to :table

  def find_by_table_number(table_number)
  	Check.where(table_id: Table.where(number: table_number).id)
  end
end
