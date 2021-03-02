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
    user_id = params[:user_id]
    @game = Game.find(params[:id])
    @user = User.find(user_id)
    if @game.users.find { |i| i[:id] == user_id.to_i} == nil
      if @game.users.count < @player_limit
        GameUser.create(game: @game, user: @user)
        set_status 0 if @game.users.count == 1
        @players_left = @player_limit - @game.users.count
        json_response(@players_left, :created)
        set_status 1 if @game.users.count == @player_limit
      end
    else
      json_response({error: "User has already been added"}, :ok)
    end

  end

  def delete_player
    @game = Game.find(params[:id])
    if @game.status == "formation"
      @game_user = GameUser.find_by game_id: params[:id], user_id: params[:user_id]
      unless @game_user.nil?
        @game_user.destroy
        head :no_content
      else
        head :not_found
      end
    end
  end

  def set_status(type)
    case type
    when 0
      @game.update(status: 0)
    when 1
      @game.update(status: 1)
    when 2
      @game.update(status: 2)
      start_game
    end
  end

  def status
    @game = Game.find(params[:id])
    json_response(@game.status)
  end

  def start_game
    p 'GAME STARTED'
  end

  private

  def items_params
    params.permit(:topic, :kind, :status, :score )
  end

end
