class Order < ActiveRecord::Base
  attr_accessible :captain_name, :cashier_name, :check_id, :min_charge, :number_of_customers, :table_number
  has_and_belongs_to_many :items
  belongs_to :check
end
