class Customers::CartItemsController < ApplicationController
    # before_action :setup_item, only: [:destroy]
     before_action :authenticate_customer!


  def index
    @cart_items = current_customer.cart_items
  end
  #商品変更
  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to customers_cart_items_path, notice: 'カート内の商品が変更されました'
  end
  # 商品追加
  def create
    @cart_item = current_customer.cart_items.new(cart_item_params)

    if !@cart_item.amount.nil?   #個数が空っぽの場合は
      
       @cart_item.save!
      redirect_to customers_cart_items_path, notice: 'カート内に商品が追加されました'
    else
      redirect_to customers_item_path(@cart_item.item), notice: 'カートに商品を入れて下さい'
    end
  end

  # 商品を１つ削除
  def destroy
    @cart_item = CartItem.find(params[:id])
		@cart_item.destroy
    redirect_to customers_cart_items_path, notice: '削除しました'
  end

  def all_destroy
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
    redirect_to customers_cart_items_path, notice: 'カートを空にしました'
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id)
  end



end
