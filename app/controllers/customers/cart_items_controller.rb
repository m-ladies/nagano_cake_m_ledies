class Customers::CartItemsController < ApplicationController
    # before_action :setup_item, only: [:destroy]
     before_action :authenticate_customer!

  
  def index
    @cart_items = current_customer.cart_items
    @sum = 0  #初期設定
  end
  
  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to customers_cart_items_path, notice: 'カート内の商品が変更されました'
  end
	
  def create
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
      @cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      @cart_item.amount += params[:cart_item][:amount].to_i
      @cart_item.save
      redirect_to cart_items_path, notice: '変更しました'
    else
      @cart_item = CartItem.new(cart_item_params)
      @cart_item.save
      redirect_to cart_items_path
    end
  end
  
  def destroy
    @cart_item = CartItem.find(params[:id])
		@cart_item.destroy
    redirect_to cart_items_path, notice: '削除しました'
  end

  def all_destroy
    @cart_items = current_customer.cart_items
    @cart_items.all_destroy
    redirect_to cart_items_path, notice: 'カートを空にしました'
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id, :customer_id)
  end

  

end
