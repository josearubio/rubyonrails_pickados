class WelcomeController < ApplicationController
  def index
    @pick = current_user.picks.build if logged_in?
    @picks= current_user.feed.paginate(page: params[:page], :per_page => 5) if logged_in?
    if !params[:sport].nil?
      if params[:sport]!='todos'
      @picks= current_user.feed.where("deporte = ?",params[:sport]).paginate(page: params[:page], :per_page => 5) if logged_in?
        else @picks=Pick.all.paginate(page: params[:page], :per_page => 5) if logged_in?
      end
    end
  end
end
