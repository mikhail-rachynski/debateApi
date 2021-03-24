class Api::V1::GamesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy, :update, :add_player, :delete_player]

  def index
    @games = Game.all.order(:id)
    render 'index.json.jbuilder'
  end

  def show
    @game = Game.find(params[:id])
    render 'show.json.jbuilder'
  end

  def create
    current_user.games.create(items_params)
        .add_player(current_user.id, GameUser.roles.key(0))
    @games = Game.all.order(:id)
    render 'index.json.jbuilder'
  end

  def update
    current_user.games.find(params[:id]).update(items_params)
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
  end

  def add_player
    @game = Game.find(params[:id])
    @games = @game.add_player(current_user.id)
    render 'index.json.jbuilder'
  end

  def delete_player
    @game = Game.find(params[:id])
    @game.delete_player(current_user.id)
  end

  def status
    @game = Game.find(params[:id])
    json_response(@game.status)
  end

  def get_rounds
    game = Game.find(params[:id])
    json_response(game.rounds)
  end

  def set_rating
    round = Round.find(params[:round_id])
    round.set_rating(params[:value]) if
        current_user
            .game_users
            .find_by(game: round.game)
            .role == GameUser.roles.key(0)
  end

  private

  def items_params
    params.permit(:topic, :kind, :score )
  end

end
