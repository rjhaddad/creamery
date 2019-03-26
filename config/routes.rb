Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :assignments
  resources :stores, only: [:new, :create, :destroy]
  resources :employees
  
  root 'stores#new'
end
