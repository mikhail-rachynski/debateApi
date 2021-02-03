class Api::V1::GamesController < ApplicationController
  def index
    @games = Game.all.order(:id)
    json_response(@games)

  end

  def show
    @game = Game.find(params[:id])
    json_response(@game)
  end

  def create
    @new_game = Game.create(items_params)
    json_response(@new_game, :created)
  end

  def add_player
    @game = Game.find(params[:id])
    @user = User.find(params[:user_id])
    GameUser.create(game: @game, user: @user, role: params[:role])
    json_response( :created)
  end

  private

  def items_params
    params.permit(:topic, :kind )
  end
end
