class AccountActivationsController < ApplicationController

  def edit
    #Obtenemos usuario
    user = User.find_by(email: params[:email])
    #Comprobamos si el usuario es corracto, si el usuario no está activado, y si el token
    #corresponde con el de dicho usuario.
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      #Activamos el usuario setteando a true el valor activated
      user.activate
      #Lo logueamos
      log_in user
      flash[:success] = "Cuenta activada!"
      redirect_to user
    else
      flash[:danger] = "Link de activación erróneo"
      redirect_to root_url
    end
  end

end
