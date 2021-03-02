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

    find_duplicate_user = @game.users.find_by id: user_id.to_i
    if find_duplicate_user.nil?
      if @game.users.count < @player_limit && @game.status == Game.statuses.key(0)
        GameUser.create(game: @game, user: @user)
        @players_left = @player_limit - @game.users.count
        json_response(@players_left, :created)
        start_game if @game.users.count == @player_limit
      else
        @error = "Players limit reached"
        render 'api/v1/error.json.jbuilder'
      end
    else
      @error = "User has already been added"
      render 'api/v1/error.json.jbuilder'
    end
  end

  def delete_player
    @game = Game.find(params[:id])
    if @game.status == Game.statuses.key(0)
      @game_user = GameUser.find_by game_id: params[:id], user_id: params[:user_id]
      unless @game_user.nil?
        @game_user.destroy
        head :no_content
      else
        head :not_found
      end
    end
  end

  def set_users_roles
    count = 0
    GameUser.where(game_id: @game.id).find_each do |item|
      item.update(role: GameUser.roles.key(count))
      count += 1
    end
  end

  def status
    @game = Game.find(params[:id])
    json_response(@game.status)
  end

  def start_game
    set_users_roles
    @game.update(status: 1)
  end

  private

  def items_params
    params.permit(:topic, :kind, :score )
  end

end
