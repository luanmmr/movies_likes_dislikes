Rails.application.routes.draw do
  devise_for :users
  root to: 'movies#index'
  resources :likes, only: [:create]
  resources :dislikes, only: [:create]
  get 'movies/report', to: 'movies#report'
end
