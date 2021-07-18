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


  # customer
  devise_for :customers, controllers: {
  sessions:      'customers/sessions',
  passwords:     'customers/passwords',
  registrations: 'customers/registrations'
}



  # 顧客
  namespace :customers do
    resources :items, only:[:index, :show]
    resources :cart_items, :addresses

    resources :customers, only:[:show, :update]

    resources :orders,only: [:new,:index,:show,:create] do
      collection do
        post 'log'
        get 'thanx'
      end
    end

  end
end
