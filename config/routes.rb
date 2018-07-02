Rails.application.routes.draw do
  resources :words, only: [:create]
  delete '/words/:text', to: 'words#destroy'
  delete '/words', to: 'words#destroy'

  get '/anagrams/:text', to: 'anagrams#index'

  get '/analytics', to: 'analytics#show'
end
