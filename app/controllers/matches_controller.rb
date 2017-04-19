class MatchesController < ApplicationController
  def index
    @matches = Match.all
  end

  def show
    @match = Match.find(params[:id])
  end

  def create
    Match.generate
    redirect_to matches_path
  end
end
