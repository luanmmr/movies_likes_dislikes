Rails.application.routes.draw do
  devise_for :users
  root to: 'movies#index'
  resources :likes, only: [:create, :destroy]
  resources :dislikes, only: [:create, :destroy]
  get 'movies/report', to: 'movies#report'
end
