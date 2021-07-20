Rails.application.routes.draw do



  root 'customers/items#top'
  get 'items' => 'customers/items#about'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.
  # root 'customers/items#top'

  #管理者
  devise_for :admins, :controllers => {
    registrations: "admins/registrations",
    sessions: "admins/sessions",
  }

  namespace :admin do
    get "homes/top" => "homes#top"
    resources :items
    resources :customers
    resources :orders, only: [:show]
    resources :genres,only: [:index,:create,:edit,:update]
    


  end


  # customer
  devise_for :customers, controllers: {
  sessions:      'customers/sessions',
  passwords:     'customers/passwords',
  registrations: 'customers/registrations'
}

  namespace :customers do

    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :update, :create, :destroy] do
      collection do
        delete 'all_destroy'
      end
    end

      # get=データを取得する処理、patch=情報を更新する(SQLでいうupdate)
      resources :customers,only: [:show, :edit, :update] do
        collection do
          get 'quit'
          patch 'out'
        end
      # collection=resourcesでは自動生成されないものに使う。生成するroutingに:idがつかない。

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
