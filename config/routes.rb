Rails.application.routes.draw do
    # Routes for main resources
  resources :stores
  resources :employees
  resources :assignments
  resources :jobs
  resources :shifts
  resources :flavors
  resources :users
  resources :sessions
  resources :shift_jobs
  resources :store_flavors
  
  # Set the root url

  root :to => 'home#index' 

  get 'signup' => 'users#new', :as => :signup
  get 'login' => 'sessions#new', :as => :login
  get 'logout' => 'sessions#destroy', :as => :logout  
  
  # Semi-static page routes
  get 'home' => 'home#home', as: :home
    get 'guest' => 'home#guest', as: :guest

  get 'about' => 'home#about', as: :about
  get 'contact' => 'home#contact', as: :contact
  get 'privacy' => 'home#privacy', as: :privacy

  get 'home/dashboard' => 'home#dashboard', :as => :dashboard
  get 'home/manage_shifts' => 'home#manage_shifts', :as => :myshifts
  get 'home/past_shifts' => 'home#past_shifts', :as => :past_shifts
  get 'home/future_shifts' => 'home#future_shifts', :as => :future_shifts
  get 'home/account' => 'home#account', :as => :account
  get 'home/employee_shifts' => 'home#employee_shifts', :as => :employee_shifts
  get 'home/employee_home' => 'home#employee_home', :as => :employee_home
  get 'home/admin_home' => 'home#admin_home', :as => :admin_home
  get 'home/guest_homepage' => 'home#guest_homepage', :as => :guest_homepage
  get 'home/manager_home' => 'home#manager_home', :as => :manager_home
  get 'shift/incomplete_shifts' => 'shifts#incomplete_shifts', :as => :incomplete_shifts

  patch 'start_shift/:id' => 'shifts#start_shift', as: :start_shift
  patch 'end_shift/:id' => 'shifts#end_shift', as: :end_shift


end
