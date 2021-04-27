class Api::V1::RoundsController < ApplicationController

  def index
    game = Game.find(params[:game])
    @rounds = game.rounds
    render "index.json.jbuilder"
  end

  def set_rating
    round = Round.find(params[:id])
    round.set_rating(params[:value]) if
        current_user
            .game_users
            .find_by(game: round.game)
            .role == GameUser.roles.key(0)

    json_response(round.game.rounds)
  end

  def play_round(game)
    thisGame = Game.find(game.id)
    rounds_count = thisGame.rounds.length
    if rounds_count < 8
      Round.new(game: thisGame).set_round(rounds_count)
      Thread.new do
        round_duration = 300
        end_time = Time.now.to_i+round_duration
        while true
          if Time.now.to_i > end_time
            play_round(thisGame)
            break
          end
          sleep 1
        end
      end
    end
  end

end