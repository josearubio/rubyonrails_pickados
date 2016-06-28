class PicksController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
	def index
    @picks = Pick.where(show: true)
  	end

	def new
	@pick = Pick.new
	end

	def edit
	  @pick= Pick.find(params[:id])
	end

	def create
	#render plain: params[:pick].inspect
  @pick = current_user.picks.build(pick_params)
	#@pick = Pick.new(pick_params)
    if !@pick.pickdate.nil?
       if @pick.pickdate > Time.now+9*60
            if @pick.save
              flash[:success] = "Pick creado correctamente!"
              redirect_to root_url
          else
            render 'new'
            end
       else
         flash[:danger] = "El evento del pick debe jugarse a partir de 10 minutos en adelante"
         render 'new'
       end
    else
      #flash[:danger] = "Error al registrar fecha"
      render 'new'
    end

	end

	def update
	  @pick= Pick.find(params[:id])
	 
	  if @pick.update(pick_params)
	    redirect_to @pick
	  else
	    render 'edit'
	  end
	end
 	
 	def destroy
	 @pick= Pick.find(params[:id])
	  @pick.destroy
   flash[:success] = "Pick borrado!"
	  redirect_to root_url
  end

def mostrarexplicacion
  respond_to do |format|
    format.html { redirect_to current_user }
    format.js {
      render :template => 'picks/comment.js.erb'
    }
  end
  end
  def tickar
    @pick=Pick.find(params[:id])
    @pick.setticked(params[:result])
    @pick.addonstats
    respond_to do |format|
      format.html { redirect_to current_user }
      format.js {
        render :template => 'picks/tick.js.erb'
      }

    end
  end

  def report
    @pick= Pick.find(params[:id])
    @pick.reportpick
    redirect_to root_path
  end

  def fav
    @pick=Pick.find(params[:id])
    current_user.fav(@pick)
    respond_to do |format|
      format.html { redirect_to current_user }
      format.js {
        render :template => 'picks/fav.js.erb'
      }
    end
  end

  def unfav
    @pick=Pick.find(params[:id])
    current_user.unfav(@pick)
    respond_to do |format|
      format.html { redirect_to current_user }
      format.js {
        render :template => 'picks/fav.js.erb'
      }

    end
  end

  private
	  def pick_params
	    params.require(:bugtracker).permit(:evento, :pronostico,:cuota,:deporte,:categoria,:stake,:bookie,:pickdate,:explicacion)
    end

  def correct_user
    @pick = current_user.picks.find_by(id: params[:id])
    redirect_to root_url if @pick.nil?
  end
end
