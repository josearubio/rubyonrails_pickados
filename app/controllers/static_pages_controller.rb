class StaticPagesController < ApplicationController
  def mispicks
    @pick = current_user.picks.build if logged_in?
    @user = User.find(params[:id])
    @picks = @user.picks.paginate(page: params[:page], :per_page => 6) if logged_in?
  end

  def faq
  end

  def contacto
  end
end
