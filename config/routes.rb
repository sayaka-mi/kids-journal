Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#index'

  resources :children
  resources :posts
end
