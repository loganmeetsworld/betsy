Rails.application.routes.draw do
  root 'home#index'

  post '/products/:id/add' => 'orderitems#add_to_cart'

  resources :products do
    resources :reviews
  end

  resources :categories, only: [:new, :create]
<<<<<<< HEAD
  
  get '/products/robots/:robot_name', to: 'products#robot', as: 'by_robot'
  get '/products/categories/:category_name', to: 'products#category', as: 'by_category'
=======
>>>>>>> cf1eb31c76f5f9a9728ddbc1fa16a1ff92e761c4

  resources :robots

  resources :orders
end
