class ApplicationController < ActionController::Base

   #ログイン後の遷移画面(管理者&顧客)
  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_homes_top_path
    when Customer
      root_path
    end
  end

  #ログアウト後の遷移画面(管理者&顧客)
  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin
      new_admin_session_path
    else
      root_path
    end
  end


   before_action :configure_permitted_parameters, if: :devise_controller?
   #before_action :authenticate_customer!,except: [:new, :about, :index, :show]
   #before_action :authenticate_admin!,except: [:new, :about, :index]


   protected
   # 新規登録の保存機能
   def configure_permitted_parameters
       devise_parameter_sanitizer.permit(:sign_up,
  	   keys: [:first_name, :last_name, :first_name_kana, :last_name_kana,
              :email, :postal_code, :address, :telephone_number])
   end


end
