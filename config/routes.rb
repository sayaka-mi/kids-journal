Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#index'

  resources :children do
    resources :records, only: [:new, :create, :index, :edit, :update, :destroy]
  end

  resources :posts
end
