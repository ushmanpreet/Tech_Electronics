Rails.application.routes.draw do
  root 'products#index'

  # Admin routes
  get '/admin/login', to: 'admin/sessions#login', as: 'admin_login'
  get '/admin/dashboard', to: 'admin/sessions#dashboard', as: 'admin_dashboard'
  post '/admin/authenticate', to: 'admin/sessions#authenticate', as: 'admin_authenticate'
  delete '/admin/logout', to: 'admin/sessions#destroy', as: 'admin_logout'
  namespace :admin do
    resources :products
  end

  # Non-admin routes
  resources :products, only: [:index, :show] do
    post 'add_to_cart', on: :collection
  end
  resources :categories, only: [:show]
  get 'categories/:id/products', to: 'categories#products', as: 'category_products'

  # Cart routes
  resource :cart, only: [:show] do
    post 'update_quantity', on: :collection
    delete 'remove_from_cart', on: :collection
  end

  # Health check route
  get 'up', to: 'rails/health#show', as: 'rails_health_check'
end
