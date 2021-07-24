class Customers::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
  end

  def to_log
    # binding.pry
    @orders = Order.all
    @shipping_cost = 800
    @order = Order.new(order_params)
    if params[:order][:address_status] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:address_status] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:order][:address_status] == "2"
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    #カスタマーの住所登録と入力内容の確認
      @address = current_customer.addresses.build
      @address.postal_code = params[:order][:postal_code]
      @address.address = params[:order][:address]
      @address.name = params[:order][:name]
      @address.save
    end
    @cart_items = current_customer.cart_items
  end

  def create
    # binding.pry
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order_status = "入金待ち"
    @order.total_payment = params[:order][:total_payment]
    @order.save
    @cart_items = current_customer.cart_items
    @cart_items.each do |cart_item|
      OrderDetail.create(
        item_id: cart_item.item.id,
        order_id: @order.id,
        amount: cart_item.amount,
        #sub_price: cart_item.item.price
      )
    end

    @cart_items.destroy_all
    redirect_to thanx_customers_orders_path
  end

  def thanx
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_detail
  end

  private

  def order_params
    params.require(:order).permit( :address, :postal_code, :name, :payment_method, :total_payment, :order_status, :shipping_cost)
  end
end