module Admin::OrderDetailsHelper
    
   # 小計
  def sub_price(sub)
    sub.item.price * sub.amount
  end
  
  # 商品合計
  def total_price(totals)
    price = 0                   
    totals.each do |total|
      price += sub_price(total)
    end
    return price
  end
    
end
