class MatchesController < ApplicationController
  include IsAdmin
  before_action :is_admin?, only: [:index, :generate]
  before_action :authenticate_user!

  def index
    if !is_admin?
      redirect_to user_path(current_user.id)
    end
    @past_matches = Match.select{|match| match.date < Date.today}.sort_by{|match| match.date}
    @todays_matches = Match.select{|match| match.date == Date.today}
    @future_matches = Match.select{|match| match.date > Date.today}.sort_by{|match| match.date}
  end

  def show
    @match = Match.find(params[:id])
  end

  def generate
    Match.generate(params[:date])
    redirect_to matches_path
  end
end
