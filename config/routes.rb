Rails.application.routes.draw do
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end
  namespace :api do
    resources :users, only: [:create]
    resources :products, only: [:create, :show, :index, :destroy, :update]
    resources :likes, only: [:create, :show, :index, :destroy]
    resources :orders, only: :index
  end
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  devise_for :users
  
  root "products#index"

  get "/products/:id/sell", to: "products#sell_details"
  get "/products/:id/buy", to: "products#buy_details"
  put "/products/:id/buy", to: "products#buy"
  get "/products/sell", to: "products#sell_list"

  resources :products do
    resources :feedbacks
  end
  resources :orders
end
