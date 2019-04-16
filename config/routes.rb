Rails.application.routes.draw do
  resources :controllers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  resources :home
  resources :assignments
  resources :employees
  resources :stores
  resources :flavors
  resources :jobs
  resources :shifts
  resources :users
  #resources :sessions
  resources :shift_jobs
  resources :store_flavors

  # Semi-static page routes
  #get 'home' => 'home#home', as: :home
  get 'about' => 'home#about', as: :about
  get 'contact' => 'home#contact', as: :contact
  get 'privacy' => 'home#privacy', as: :privacy
  
  # resources :assignments
  # resources :stores, only: [:new, :create, :destroy]
  # resources :employees
  

  # Set the root url
	root 'home#index'
	
end
