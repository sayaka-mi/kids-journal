Rails.application.routes.draw do
  devise_for :users
  root to: 'children#index'

  resources :children do
    resources :records, only: [:new, :create, :index, :edit, :update, :destroy]
    resources :vaccination_records, only: [:index, :destroy] do
      collection do
        post :create_or_update
      end
    end
    resources :height_weights do
      collection do
        get :chart
      end
    end
  end

  resources :posts
  post 'select_child', to: 'children#select_child', as: :select_child

  resources :tags, only: [:index]

  resources :records, only: [:index] do
    collection do
      get :search
    end
  end

  resources :shared_users, only: [:index, :create, :destroy]
end
