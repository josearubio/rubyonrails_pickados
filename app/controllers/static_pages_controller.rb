class StaticPagesController < ApplicationController
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
    @picks= Pick.all.paginate(page: params[:page], :per_page => 20) if logged_in?
    if !params[:sport].nil?
      if params[:sport]!='todos'
        @picks= current_user.feed.where("deporte = ?",params[:sport]).paginate(page: params[:page], :per_page => 5) if logged_in?
      else @picks=Pick.all.paginate(page: params[:page], :per_page => 5) if logged_in?
      end
    end
  end

  def faq
  end

  def contacto
  end
end
