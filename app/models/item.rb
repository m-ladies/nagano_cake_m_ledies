class Item < ApplicationRecord

  attachment :image


    has_many :order_details
    has_many :cart_items
    belongs_to :genre


end
