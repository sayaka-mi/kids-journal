Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#index'

  resources :children do
    resources :records
  end

  resources :posts
end
