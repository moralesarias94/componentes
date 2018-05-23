require 'net/http'

module SessionsHelper

  # Guardar el token del usuario en una cookie
  def log_in(token)
    session[:token] = token
  end

  def current_user
    if @current_user.nil?
      token = session[:token]
      uri = URI.parse("http://localhost:4000/users/getusuario")
      Net::HTTP.start(uri.host, uri.port) do |http|
        request = Net::HTTP::Get.new uri
        request.add_field("Authorization",token)
        response = http.request request
        user = JSON.parse(response.body)
        @current_user = user['email']
      end
    else
      @current_user
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:token)
    @current_user = nil
  end
end
