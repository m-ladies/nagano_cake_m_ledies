class Customers::AddressesController < ApplicationController
#   before_action :authenticate_customer!

  def index
  	@addresses = current_customer.addresses
  	@address = Address.new
  end

  def create
	  @address = Address.new(address_params)
	  @address.customer_id = current_customer.id
      if @address.save
	      redirect_to customers_addresses_path, notice: '新規配送先を登録しました'
      else
        @customer = current_customer
        @addresses = @customer.addresses.all
        render "index"
      end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
	  @address = Address.find(params[:id])
	    if @address.update(address_params)
        redirect_to customers_addresses_path, notice: '配送先を変更しました'
	    else
	      render "edit"
	    end
  end

  def destroy
	  @address = Address.find(params[:id])
	  @address.destroy
	  redirect_to customers_addresses_path, alert: '配送先を削除しました'
  end

  private

  def address_params
  	params.require(:address).permit(:postal_code, :address, :name)
  end
end
