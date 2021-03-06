class Item < ApplicationRecord

  attachment :image

    belongs_to :genre
    has_many :order_details
    has_many :cart_items


    validates :name, :introduction, :price,  presence: true

  # 税抜き価格計算式
   def add_ex_price
    (self.price / 1.08).round
   end

end
