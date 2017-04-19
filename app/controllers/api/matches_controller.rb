class Api::MatchesController < ApplicationController

  def index
    render status: 200, json: {
      matches: Match.all
    }.to_json
  end


end
