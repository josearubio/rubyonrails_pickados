class RankingController < ApplicationController
  def index
    @ranks = Stat.where("created_at BETWEEN ? AND ?", Time.now.beginning_of_month, Time.now.end_of_month).order(yield: :desc)
  end
end
