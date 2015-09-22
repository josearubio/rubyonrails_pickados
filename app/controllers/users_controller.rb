class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user, only: [:index]
  before_action :tipsterbought, only: [:show]

  def index
    @users = User.paginate(page: params[:page], :per_page => 5)
  end

  def show
    @user = User.find(params[:id])
    @picks = @user.picks.paginate(page: params[:picks_page], :per_page => 6)
    @tickados = @user.picks.where("status = ?",'ticked').paginate(page: params[:ticks_page], :per_page => 20)

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

  def following
    @user = User.find(params[:id])
    @following = @user.following.paginate(page: params[:following_page], :per_page => 10)
    @tickados = @user.picks.where("status = ?",'ticked').paginate(page: params[:ticks_page], :per_page => 10)
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.paginate(page: params[:followers_page], :per_page => 10)
    @tickados = @user.picks.where("status = ?",'ticked').paginate(page: params[:ticks_page], :per_page => 10)
  end

  def tipsterbought
    @user = User.find(params[:id])
    if @user.pro == 1 && @user!=current_user
    unless @user.followers.include?(current_user)
      flash[:danger] = "No tienes permisos para seguir a este usuario. Contrátalo si así lo desea."
      redirect_to root_path
    end
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
