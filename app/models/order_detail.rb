class OrderDetail < ApplicationRecord
    belongs_to :order
    belongs_to :items
    has_many :cart_items, through: :cart_items
end
