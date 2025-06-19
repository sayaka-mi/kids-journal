Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#index'

  resources :children do
    resources :records, only: [:new, :create, :index, :show, :destroy]
  end

  resources :posts
end
