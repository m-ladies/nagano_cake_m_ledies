class Customers::CartItemsController < ApplicationController
    # before_action :setup_item, only: [:destroy]
     before_action :authenticate_customer!

  def create
    
  end 
  
  def index
    @cart_items = current_customer.cart_items
  end

  def destroy
    @setup_item.destroy
    redirect_to current_cart
  end
  
  def all_destroy
    @cart_items = current_customer.cart_items
    @cart_items.all_destroy
    redirect_to customers_cart_items_path
  end
  

  private

  def setup_item
    @setup_item = CartItem.find(params[:id])
  end



end
