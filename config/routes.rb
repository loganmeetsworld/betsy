Rails.application.routes.draw do
  root 'home#index'

  resources :products do 
    resources :categories
  end
  
  resources :robots 
end
