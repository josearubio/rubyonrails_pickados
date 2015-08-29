class SessionsController < ApplicationController
  def new
  end

  def create

    #Primero obtenemos el usuario a través del email
    user = User.find_by(email: params[:session][:email].downcase)
    #Ahora comprobamos si la contraseña es la correcta con authenticate
    if user && user.authenticate(params[:session][:password])

      if user.activated? #Si el usuario ya está activado, nos logueamos
        #Asignamos la id del user al objeto session
        log_in user
        #Depende si hemos marcado la casilla recordar, setteamos la cookie o la borramos
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        #Redireccionamos a página de usuario
        redirect_back_or user
      else #Si no está activado mostramos el mensaje de aviso.
        message  = "Cuenta requiere activación. "
        message += "Comprueba el email para el link de activación."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = "Logueo incorrecto !"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
