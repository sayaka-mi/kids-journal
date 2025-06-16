Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#index'

  resources :children, only: [:new, :create, :index, :destroy]
end
