Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
  	authenticated :user do
		root 'products#index', as: :authenticated_root
	end

  	unauthenticated do
  		root 'devise/sessions#new', as: :unauthenticated_root
  	end
  end

  resources :stocks
  resources :products
  resources :product_categories
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
