Rails.application.routes.draw do


  
  
  root 'customers/items#top'
  get 'items' => 'customers/items#about'
  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.
 root 'customers/items#top'

  #管理者
  devise_for :admins, :controllers => {
    registrations: "admins/registrations",
    sessions: "admins/sessions",
  }

  namespace :admin do
    root 'orders#top'
    resources :items, :customers
    resources :orders, only: [:show]
    resources :genres,only: [:index,:create,:edit,:update]
    get "orders/top" => "orders#top"

  end

  
  # 顧客
  devise_for :customers, controllers: {
  sessions:      'customers/sessions',
  passwords:     'customers/passwords',
  registrations: 'customers/registrations'
}
  
  namespace :customers do
    resources :items, only:[:index, :show]
    
      # get=データを取得する処理、patch=情報を更新する(SQLでいうupdate)
      resource :customers,only: [:show, :edit] do
        collection do
          get 'quit'   
          patch 'out'
        end
      
    resources :cart_items

    resources :customers, only:[:show, :update]
    
    # collection=　resourcesでは自動生成されないものに使う。生成するroutingに:idがつかない。
    resources :orders,only: [:new,:index,:show,:create] do
      collection do
        post 'log'       
        get 'thanx'     
      end
    end
    # post=URLが保存可、get=URL保存不可
   
    resources :address,only: [:index,:create,:destroy,:edit,:update]
    end  
  end
end
