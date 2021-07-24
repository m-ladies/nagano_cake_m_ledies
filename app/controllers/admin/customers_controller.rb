class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @customers = Customer.all.page(params[:page]).per(10)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end


  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      @customer.save
      flash[:notice] = "会員情報更新しました"
      redirect_to admin_customer_path(@customer)
    else
      render :edit
    end
  end


  def check
    @customer = Customer.find(params[:id])
    #ユーザーの情報を見つける
  end

def is_deleted
    @customer = Customer.find(current_customer.id)
    #現在ログインしているユーザーを@customerに格納
    @customer.update(is_deleted: "Invalid")
    #updateで登録情報をInvalidに変更
    reset_session
    #sessionIDのresetを行う
    redirect_to root_path
    #指定されたrootへのpath
end

 private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email, :is_deleted)
  end

end
