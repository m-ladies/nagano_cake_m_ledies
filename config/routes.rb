Rails.application.routes.draw do

  
  
  root 'customers/items#top'
  get 'items' => 'customers/items#about'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.
  namespace :admin do
    resources :items, :customers, :genres, :orders
  end
  
  # customer
  devise_for :customers, controllers: {
  sessions:      'customers/sessions',
  passwords:     'customers/passwords',
  registrations: 'customers/registrations'
}
  
  namespace :customers do
    resources :items, only:[:index, :show,]
    resources :cart_items, :orders, :addresses
    resources :customers, only:[:show, :update]
  end
end
