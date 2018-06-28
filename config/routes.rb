Rails.application.routes.draw do
  resources :words, only: [:create]
end
