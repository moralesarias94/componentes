Rails.application.routes.draw do
  get '/users/getusuario', to:'users#getusuario'
  post 'authenticate', to: 'authentication#authenticate'
end
