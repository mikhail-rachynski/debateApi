class Api::V1::RoundsController < ApplicationController

  def index
    game = Game.find(params[:game])
    @rounds = game.rounds
    render "index.json.jbuilder"
  end

  def set_rating
    @round = Round.find(params[:id])
    @round.set_rating(params[:value]) if
        current_user
            .game_users
            .find_by(game: @round.game)
            .role == GameUser.roles.key(0)
    sendStarRatingToWebSocket "set_rating"
  end

end