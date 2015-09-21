class StaticPagesController < ApplicationController
  before_action :logged_in_user


  def mispicks
    @pick = current_user.picks.build if logged_in?
    @user = User.find(params[:id])
    @picks = @user.picks.paginate(page: params[:page], :per_page => 6) if logged_in?
    if !params[:sport].nil?
      @picks= @user.picks.where("deporte = ?",params[:sport]).paginate(page: params[:page], :per_page => 5) if logged_in?
    end
  end

  def index
    @pick = current_user.picks.build if logged_in?
    @picks= Pick.all.paginate(page: params[:todos_page], :per_page => 15) if logged_in?
    @verdes=Pick.where("result = ?",'ok').paginate(page: params[:verdes_page], :per_page => 3)
    @favs=Pick.joins(:passive_favorites).select('picks.*, count(pick_id) as "pick_count"').group("picks.id").order(' pick_count desc')

    if !params[:sport].nil?
      if params[:sport]!='todos'
        @picks= current_user.feed.where("deporte = ?",params[:sport]).paginate(page: params[:page], :per_page => 5) if logged_in?
      else @picks=Pick.all.paginate(page: params[:page], :per_page => 5) if logged_in?
      end
    end
  end

  def favorites
    @pick = current_user.picks.build if logged_in?
    @picks= current_user.favorites.order(pickdate: :desc).paginate(page: params[:page], :per_page => 15) if logged_in?

    #@picks.each do |p|
     # if Time.now-24*60*60 >= p.pickdate
       # current_user.unfav(p)
      #end
    #end

  end

  def reports
    @pick = current_user.picks.build if logged_in?
    @picks = Pick.where("report = ?", true).paginate(page: params[:page], :per_page => 15)
  end



  def faq
  end

  def contacto
  end
end
