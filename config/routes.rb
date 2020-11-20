Rails.application.routes.draw do

  resources :orders

  get 'kitchen', to: 'order_items#index'
  post 'kitchen_alter_item_state', to: 'order_items#alter_item_state'
  delete 'order_items', to: 'order_items#destroy'

  post 'orders_handle', to: 'orders#handle'

  get 'menu', to: 'menu#index' 

  get 'rates_list', to: 'rates#list'
  post 'rates_create_or_update', to: 'rates#save'
  
  post 'artist_suggestion_create', to: 'artist_suggestion#create'
  get 'artist_suggestion', to: 'artist_suggestion#index'
  delete 'artist_suggestion_destroy', to: 'artist_suggestion#destroy'
  
  devise_for :users, :controllers => { :registrations => 'users/registrations' }
  
  resources :users

  devise_scope :user do
  	authenticated :user do      
  		root 'stocks#index', as: :authenticated_root
  	end

  	unauthenticated do
  		root 'devise/sessions#new', as: :unauthenticated_root
  	end
  end

  resource :users do
    get ":id/inactive" => 'users#inactive', as: 'users_inactive'    
  end

  get 'access-denied' => 'users#access_denied', as: 'users_access_denied'

  resources :rates
  resources :songs
  resources :stocks
  resources :products
  resources :product_categories

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
