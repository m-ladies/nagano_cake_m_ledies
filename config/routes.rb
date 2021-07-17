Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.
 root 'customers/items#top'

  #管理者
  devise_for :admins, :controllers => {
    registrations: "admins/registrations",
    sessions: "admins/sessions",
  }

  namespace :admin do
    root 'orders#top'
    resources :items, :customers, :genres
    resources :orders, only: [:show]
    get "orders/top" => "orders#top"
  end


  namespace :customers do
    resources :items, only:[:index, :show]
    resources :cart_items, :orders, :addresses
    resources :customers, only:[:show, :update]
  end
end
