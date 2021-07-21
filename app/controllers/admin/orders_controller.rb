class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @items_total_price = calculate(@order)
    @order_details = @order.order_details.all
  end

  def create
    session[:payment] = params[:payment]
  end

 private
	def order_params
		  params.require(:order).permit(:order_status)
	end
end
