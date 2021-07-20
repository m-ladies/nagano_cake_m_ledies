class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
  end

  def create
  end

 private
	def order_params
		  params.require(:order).permit(:order_status)
	end
end
