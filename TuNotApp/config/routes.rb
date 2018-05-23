Rails.application.routes.draw do
  root 'home#index'
  get '/home', to: 'home#index'
  get '/logs', to: 'logs#index'
  post '/home/index', to: 'home#calcular'
  get '/home/index'
  delete '/home/index/:id', to: 'home#eliminar'
  get '/home/agregar'
  post '/home/agregar', to: 'home#crear'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
