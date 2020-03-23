Rails.application.routes.draw do
  resources :messages, only: %i[index show create]
  resources :votes, only: %i[create]
  resources :sessions, only: :create
end
