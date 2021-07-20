class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @items_total_price = calculate(@order)
    @order_details = @order.order_details.all
  end
  
  def calculate(items_total_price) # 商品合計を計算
    @items_total_price = 0
    @order_details.each {|order_detail|
    tax_in_price = (order_detail.item_price * 1.1).floor
    sub_total_price = tax_in_price * order_detail.quantity
    @items_total_price += sub_total_price
    }
  end

  def create
    session[:payment] = params[:payment]
  end

 private
	def order_params
		  params.require(:order).permit(:order_status)
	end
end
