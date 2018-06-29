Rails.application.routes.draw do
  resources :words, only: [:create]
  delete '/words/:text', to: 'words#destroy'
  delete '/words', to: 'words#destroy'
end
