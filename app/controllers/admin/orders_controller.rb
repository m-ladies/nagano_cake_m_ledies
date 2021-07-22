class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
  end

  def update
    
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @order.update(order_params) 
    if @order.order_status == "入金確認"
       @order_details.each do |order_detail|
        order_detail.making_status = "製作待ち"
        order_detail.save
      end
    end
    redirect_to admin_order_path
  end

 private

	def order_params
	  params.require(:order).permit(:order_status)
	end
end
