class Item < ApplicationRecord
    
    belongs_to :order_details
    has_many :cart_items

end
