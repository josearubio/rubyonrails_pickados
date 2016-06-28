class StaticPagesController < ApplicationController
  before_action :logged_in_user


  def mispicks
    @pick = current_user.picks.build if logged_in?
    @user = User.find(params[:id])
    @picks = @user.picks.where(show: true).paginate(page: params[:page], :per_page => 6) if logged_in?
    if !params[:sport].nil?
      @picks= @user.picks.where("deporte = ?",params[:sport]).where(show: true).paginate(page: params[:page], :per_page => 5) if logged_in?
    end
  end

  def index
    @pick = current_user.picks.build if logged_in?
    @picks= Pick.all.where(show: true).where("status = ? and pickdate > ?",'unstarted',Time.now).paginate(page: params[:todos_page], :per_page => 15) if logged_in?
    @verdes=Pick.where(show: true).where("result = ?",'ok').paginate(page: params[:verdes_page], :per_page => 3)
    @favs=Pick.where(show: true).joins(:passive_favorites).select('picks.*, count(pick_id) as "pick_count"').group("picks.id").where("status = ?",'unstarted').order(' pick_count desc')


    if !params[:sport].nil?
      if params[:sport]!='todos'
        @picks= current_user.feed.where(show: true).where("deporte = ?",params[:sport]).paginate(page: params[:page], :per_page => 5) if logged_in?
      else @picks=Pick.where(show: true).paginate(page: params[:page], :per_page => 5) if logged_in?
      end
    end
  end

  def favorites
    @pick = current_user.picks.build if logged_in?
    @picks= current_user.favorites.where(show: true).order(pickdate: :desc).paginate(page: params[:page], :per_page => 15) if logged_in?

    #@picks.each do |p|
     # if Time.now-24*60*60 >= p.pickdate
       # current_user.unfav(p)
      #end
    #end

  end

  def reports
    @pick = current_user.picks.build if logged_in?
    @picks = Pick.where(show: true).where("report = ?", true).paginate(page: params[:page], :per_page => 15)
  end



  def faq
  end

  def contacto
  end
end
