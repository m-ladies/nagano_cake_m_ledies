class Item < ApplicationRecord

  attachment :image

    belongs_to :genre
    has_many :order_details
    has_many :cart_items

   #消費税出すための計算記載
   def add_tax_price
    (self.price * 1.10).round
   end
end
