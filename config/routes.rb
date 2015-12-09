Rails.application.routes.draw do
  root 'home#index'

  resources :products do
    resources :reviews
  end

  resources :categories, only: [:new, :create]
  
  get '/products/robots/:robot_name', to: 'products#robot', as: 'by_robot'
  get '/products/categories/:category_name', to: 'products#category', as: 'by_category'

  resources :robots

  resources :orders 
end
