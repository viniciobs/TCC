Rails.application.routes.draw do

  post 'artist_suggestion_create', to: 'artist_suggestion#create'
  get 'artist_suggestion', to: 'artist_suggestion#index'
  delete 'artist_suggestion_destroy', to: 'artist_suggestion#destroy'

  devise_for :users

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

  resources :users
  resources :rates
  resources :songs
  resources :stocks
  resources :products
  resources :product_categories
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
