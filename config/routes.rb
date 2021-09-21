Rails.application.routes.draw do
  root to: 'teams#index'
  resources :teams, only: %i[create destroy]
  get '/:slug', to: 'teams#show'
  resources :channels, only: %i[show create destroy]
  resources :talks, only: [:show]
  resources :team_users, only: %i[create destroy]
  devise_for :users, controllers: { registrations: 'registrations' }
end
