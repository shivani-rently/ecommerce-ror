Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "products#home"

  put "/products/:id/buy", to: "products#buy"

  resources :products
end
