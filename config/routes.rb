Rails.application.routes.draw do
  root 'home#index'

  resources :products do
    resources :reviews
  end

  resources :categories only: [:new, :create]

  resources :robots

  resources :orders 
end
