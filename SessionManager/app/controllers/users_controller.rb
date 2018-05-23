class UsersController < ApplicationController

  def getusuario
    msg = {:email => @current_user.email}
    render :json => msg
  end

end
