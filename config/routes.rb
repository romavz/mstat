Rails.application.routes.draw do
  resources :messages, only: %i[index show]
  resources :sessions, only: :create
end
