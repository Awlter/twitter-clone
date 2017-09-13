TwitterClone::Application.routes.draw do
  root to: 'users#index'

  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  resources :users, only: [:new, :create] do
    member do
      post 'follow', to: 'users#follow'
      post 'unfollow', to: 'users#unfollow'
    end
  end
  resources :statuses, only: [:new, :create]

  get ':username', to: 'users#show', as: 'user'
end
