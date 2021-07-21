class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
  end
  
  def update
    
  end


 private
	def order_params
	  params.require(:order).permit(:order_status)
	end
	
	def order_detail_params
	  params.require(:order_detail).permit(:making_status)
  end
  
end
