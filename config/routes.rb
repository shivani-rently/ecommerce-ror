Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "products#home"

  get "/products/:id/sell", to: "products#sell_details"
  get "/products/:id/buy", to: "products#buy_details"
  put "/products/:id/buy", to: "products#buy"

  resources :products do
    resources :feedbacks
  end
  resources :orders
end
