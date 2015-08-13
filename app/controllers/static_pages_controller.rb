class StaticPagesController < ApplicationController
  def mispicks
    @pick = current_user.picks.build if logged_in?
    @picks= current_user.feed.paginate(page: params[:page], :per_page => 5) if logged_in?
  end

  def faq
  end

  def contacto
  end
end
