require 'net/http'
class SessionsController < ApplicationController
  def new
  end

  def create
    #Esto es ejecutado en el post del login
    #Se valida contra el servidor de autenticacion
    #En caso de que falle se vuelve a cargar la pagina de log in

    #Tomar los datos del request
    email = params[:session][:email].downcase
    password = params[:session][:password]

    #Autenticacion
    uri = URI.parse('http://localhost:4000/authenticate')
    req = Net::HTTP::Post.new(uri, initheader = {'Content-Type' => 'application/json'})
    
    req.body = {email: email, password: password}.to_json
    res = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(req)
    end
    print res.code

    if (res.code == "200")
      #La autenticacion fue exitosa
      token = JSON.parse(res.body)['auth_token']
      log_in token

      uri = URI.parse('http://localhost:5500/api/v1/actions?desc="Inicio sesion"&user=1')
      req = Net::HTTP::Post.new(uri, initheader = {'Content-Type' => 'application/json'})
      res = Net::HTTP.start(uri.hostname, uri.port) do |http|
        http.request(req)
      end
      redirect_to home_url
    else
      #Algun error ocurrio
      if(res.code == "401")
        flash.now[:danger] = 'Email o password incorrectos'
      else
        flash.now[:danger] = 'Error al conectar con el servicio de autenticación'
      end
      render 'new'
    end

  end

  def destroy
    log_out
    redirect_to root_url
  end
end
