class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def top
    @orders = Order.all.page(params[:page]).per(10)

  end


  def show
  end

  def create
  end
  
 private
	def order_params
		  params.require(:order).permit(:order_status)
	end
end
