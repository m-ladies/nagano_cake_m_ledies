class Customers::CustomersController < ApplicationController

  def show
    @customer = Customer.find(current_customer.id)
  end

  def quit
    @customer = Customer.find(current_customer.id)
  end

  def out
    @customer = Customer.find(current_customer.id)
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to root_path
  end

  def edit
    @customer = Customer.find(current_customer.id)
  end

  def update
    @customer = Customer.find(current_customer.id)
    if @customer.update(customer_params)
      flash[:success] = "登録情報を変更しました"
      redirect_to customers_customer_path
    else
      render :edit and return
    end
  end

  private

  def customer_params
  	params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number)
  end

end
