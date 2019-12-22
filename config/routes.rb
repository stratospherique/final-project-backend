Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:create, :show, :index]

  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/logged_in', to: 'sessions#is_logged_in?'

  get '/articles', to: 'articles#index'
  get '/articles/trending', to: 'articles#find_trending'
  post '/articles/add', to: 'articles#create'
  delete '/articles/:id', to: 'articles#destroy'
end
