class ApplicationController < ActionController::Base
   before_action :authenticate_customer!,except: [:new, :about, :index]
   before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :authenticate_customer!,except: [:new, :about, :index]
    # before_action :authenticate_admin!

   protected
   # 新規登録の保存機能
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up,
  			 keys: [:first_name, :last_name, :first_name_kana, :last_name_kana,
                :email, :postal_code, :address, :telephone_number])
    end

end
