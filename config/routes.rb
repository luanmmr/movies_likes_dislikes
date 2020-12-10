Rails.application.routes.draw do
  devise_for :users
  root to: 'movies#index'
  resources :likes, only: %i[create destroy]
  resources :dislikes, only: %i[create destroy]
  get 'movies/report', to: 'movies#report'
  get 'movies/charts', to: 'movies#chart'
  get 'movies/extra', to: 'movies#extra'
end
