Rails.application.routes.draw do

  resources :songs
  devise_for :users

  devise_scope :user do
  	authenticated :user do
  		root 'stocks#index', as: :authenticated_root
  	end

  	unauthenticated do
  		root 'devise/sessions#new', as: :unauthenticated_root
  	end
  end

  resources :users

  resource :users do
    get ":id/inactive" => 'users#inactive', as: 'users_inactive'
  end

  resources :stocks
  resources :products
  resources :product_categories
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
