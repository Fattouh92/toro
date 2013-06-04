class DeletedItem < ActiveRecord::Base
  attr_accessible :check_id, :item_id, :order_id
end
