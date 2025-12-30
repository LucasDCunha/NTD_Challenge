Rails.application.routes.draw do
  root "dashboard#index"

  resources :messages, only: [:new, :create]
end
