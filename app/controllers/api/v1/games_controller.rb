class Api::V1::GamesController < ApplicationController
  def index
    @games = Game.all.order(:id)
    render 'index.json.jbuilder'
  end

  def show
    @game = Game.find(params[:id])
    render 'show.json.jbuilder'
  end

  def create
    @new_game = Game.create(items_params)
    json_response(@new_game, :created)
  end

  def update
    @game = Game.find(params[:id])
    @game.update(items_params)
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
  end

  def add_player
    @player_limit = 9
    @game = Game.find(params[:id])
    @user = User.find(params[:user_id])
    if @game.users.count < @player_limit
      GameUser.create(game: @game, user: @user, role: params[:role])
    end
    @players_left = @player_limit - @game.users.count
    json_response(@players_left, :created)
  end

  def status
    @game = Game.find(params[:id])
    json_response(@game.status)
  end


  private

  def items_params
    params.permit(:topic, :kind )
  end
end
