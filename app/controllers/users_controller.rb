class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user, only: [:index]

  def index
    @users = User.paginate(page: params[:page], :per_page => 5)
  end

  def show
    @user = User.find(params[:id])
    @picks = @user.picks.paginate(page: params[:page], :per_page => 6)

    if !params[:sport].nil?
      @picks= @user.picks.where("deporte = ?",params[:sport]).paginate(page: params[:page], :per_page => 6) if logged_in?
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def setpro
    @user = User.find(params[:id])
    @user.setprotipster
    redirect_to root_path
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Por favor inicia sesión."
      redirect_to login_url
    end
  end

  def admin_user
    logged_in_user
    unless admin?
      store_location
      flash[:danger] = "No estás autorizado para realizar esta acción."
      redirect_to root_url
    end
  end

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
