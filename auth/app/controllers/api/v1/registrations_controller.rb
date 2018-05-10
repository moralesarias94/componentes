class Api::V1::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token
respond_to :json

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def create
    user = User.new(user_params)
    if user.save
      render :json=> user.as_json(:message=>'creado con exito', :email => user.email ), :status=>201
      return
    else
      warden.custom_failure!
      render :json => user.errors, :status=>422
    end
  end

  private
  def user_paramssignin
    params.require(:user).permit(:email,:password,:password_confirmation,:mobile,:name)
  end

end
