class Item < ApplicationRecord

  attachment :image


    belongs_to :order_detail
    has_many :cart_items

end
