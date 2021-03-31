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

  private

  def items_params
    params.permit(:topic, :kind, :score )
  end

end
