class Customers::CartItemsController < ApplicationController
    # before_action :setup_item, only: [:destroy]
  
  def index
    @cart_items = current_cart
  end 
  
  def destroy
    @setup_item.destroy
    redirect_to current_cart
  end
  
  private
  
  def setup_item
    @setup_item = CartItem.find(params[:id])
  end
        
        
        
end
