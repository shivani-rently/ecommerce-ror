Rails.application.routes.draw do
  namespace :api do
    resources :products, only: [:create, :show, :index, :destroy, :update]
  end
  namespace :api do
    resources :orders, only: :index
  end
  namespace :api do
    resources :likes, only: [:create, :show, :index, :destroy]
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  devise_for :users
  
  root "products#home"

  get "/products/:id/sell", to: "products#sell_details"
  get "/products/:id/buy", to: "products#buy_details"
  put "/products/:id/buy", to: "products#buy"
  get "/products/sell", to: "products#sell_list"

  resources :products do
    resources :feedbacks
  end
  resources :orders
end
