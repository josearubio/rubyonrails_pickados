class WelcomeController < ApplicationController
  def index
    @pick = current_user.picks.build if logged_in?
    @picks= Pick.paginate(page: params[:page], :per_page => 5)
  end
end
