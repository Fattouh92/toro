class Order < ActiveRecord::Base
  attr_accessible :captain_name, :cashier_name, :check_id, :total
  has_and_belongs_to_many :items
  belongs_to :check
  validates_presence_of :check_id

  def add_item(item_id)
    order = Order.find(self.id)
    item = Item.find(item_id)
    order.items << item
  end

end
