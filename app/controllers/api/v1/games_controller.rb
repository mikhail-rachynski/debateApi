class Api::V1::GamesController < ApplicationController
  def index
    @games = Game.all.order(:id)
    json_response(@games)

  end

  def show
    @games_count = Game.take(params[:id])
    json_response(@games_count)
  end

  def create
    @game = Game.create(items_params)
    json_response(@game, :created)
  end
  private

  def items_params
    params.permit(:topic, :kind )
  end
end
