class Api::V1::GamesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy, :update, :add_player, :delete_player]

  def index
    @games = Game.all.order(:id)
    # @games.map{| item | item.score = rating_calculation(item.rounds)}
    render 'index.json.jbuilder'
  end

  def show
    @game = Game.find(params[:id])
    @game.score = 0
    # @game.score = rating_calculation(@game.rounds)
    render 'show.json.jbuilder'
  end

  def create
    @game = current_user.games.create(items_params)
    @games = Game.all.order(:id)
    pub_game "add_game", @game

  end

  def update
    current_user.games.find(params[:id]).update(items_params)
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    pub_deleted_game_id "delete_game", @game.id
  end

  def add_player
    @game = Game.find(params[:id])
    @games = @game.add_player(current_user)
    pub_game_users "add_player", @game
  end

  def delete_player
    @game = Game.find(params[:id])
    @game.delete_player(current_user.id)
    pub_game_users "delete_player", @game
  end

  def status
    @game = Game.find(params[:id])
    json_response(@game.status)
  end

  private

  def items_params
    params.require(:game).permit(:topic, :kind, :score )
  end

  # def rating_calculation(rounds)
  #   government_team = rounds.government.inject(0){|result, element| result + element.rating}.to_f/4
  #   opposition_team = rounds.opposition.inject(0){|result, element| result + element.rating}.to_f/4
  #   government_team/(government_team + opposition_team)*100
  # end

end
