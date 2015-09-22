class RankingController < ApplicationController
  def index
    @pasado = Stat.where("created_at BETWEEN ? AND ?", (Time.now - 1.month).beginning_of_month, (Time.now - 1.month).end_of_month).order(yield: :desc).limit(5)
    @ranks = Stat.where("created_at BETWEEN ? AND ?", Time.now.beginning_of_month, Time.now.end_of_month).order(yield: :desc).limit(5)
  end
end
