Rails.application.routes.draw do
  namespace :api do
    resources :likes, only: [:create, :show, :index]
  end
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
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
