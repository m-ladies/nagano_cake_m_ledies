Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.
  namespace :admin do
    resources :items, :customers, :genres, :orders
  end
  
  namespace :customers do
    resources :items, only:[:index, :show]
    resources :cart_items, :orders, :addresses
    resources :customers, only:[:show, :update]
  end
end
