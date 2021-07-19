class Customers::OrdersController < ApplicationController

# before_action :to_log, only: [:show]
# before_action :authenticate_customer!

#   def new
#   	@order = Order.new
#   	@address = Address.where(customer: current_customer)
#   end

  def log
    @cart_items = current_cart
    @order = Order.new(
    customer: current_customer,
    payment_method: params[:order][:payment_method]
    )

    # total_paymentに請求額を代入
    @order.total_payment = billing(@order)

    # addressに会員の値がはいっていれば
    if params[:order][:address] == "current_customer.address"
      @order.postal_code = current_customer.postal_code
      @order.address     = current_customer.residence
      @order.name        = current_customer.last_name +
                           current_customer.first_name

    # addressにaddresses(配送先)の値がはいっていれば
    elsif params[:order][:address] == "addresses"
      ship = Address.find(params[:order][:address_id])
      @order.postal_code = ship.postal_code
      @order.address     = ship.address
      @order.name        = ship.name

    # addressにnew_addressの値がはいっていれば
    elsif params[:order][:address] == "new_address"
      @order.postal_code = params[:order][:postal_code]
      @order.address     = params[:order][:address]
      @order.name        = params[:order][:name]
      @ship = "1"

      # バリデーションがあるならエラーメッセージを表示
      unless @order.valid? == true
        @address = Address.where(customer: current_customer)
        render :new
      end
    end
  end

	def create
    @order = current_customer.orders.new(order_params)
    @order.save
    flash[:notice] = "ご注文が確定しました。"
    redirect_to thanx_customers_orders_path

    # もし情報入力でnew_addressの場合ShippingAddressに保存
    if params[:order][:ship] == "1"
      current_customer.address.create(address_params)
    end

    # カート商品の情報を注文商品に移動
    @cart_items = current_cart
    @cart_items.each do |cart_item|
    OrderDetail.create(
      item:  cart_item.item,
      order:    @order,
      amount: cart_item.amount,
      subprice: sub_price(cart_item)
    )
    end
    # 注文完了後、カート商品を空にする
    @cart_items.destroy_all
	end

	def thanx
	end

	def index
    @orders = current_customer.orders
	end

	def show
	  @order = Order.find(params[:id])
    @order_details = @order.order_details
	end

  private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :payment_method, :total_payment)
  end

  def address_params
    params.require(:order).permit(:postal_code, :address, :name)
  end

  def to_log
    redirect_to customers_cart_items_path if params[:id] == "log"
  end
end
