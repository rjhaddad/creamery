Rails.application.routes.draw do
  resources :controllers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  

  resources :assignments
  resources :employees
  resources :stores
  resources :home


  # resources :assignments
  # resources :stores, only: [:new, :create, :destroy]
  # resources :employees
  

  # Set the root url
	root 'home#index'
	
end
