class PicksController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

	def index
    @pick = Pick.all
  	end

	 def show
    @pick = Pick.find(params[:id])
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
 
	  	if @pick.save
        flash[:success] = "Pick creado correctamente!"
        redirect_to root_url
	  else
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
	 
	  redirect_to picks_path
	end

	private
	  def pick_params
	    params.require(:pick).permit(:evento, :pronostico,:cuota,:deporte,:categoria,:stake)
	  end
end
