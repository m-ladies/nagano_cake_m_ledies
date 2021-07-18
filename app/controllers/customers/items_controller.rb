class Customers::ItemsController < ApplicationController

  
  def top
    @items = Item.all
  end 
  
  def about
  end
  
  def index
     @items = Item.all.page(params[:page]).reverse_order.per(8)
  end 
  
  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    
  end 
  

end
