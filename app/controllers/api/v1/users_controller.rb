class Api::V1::UsersController < ApplicationController

  def index
    @users = User.all.order(:id)
    json_response(@users)

  end

  def show
    @user = User.find(params[:id])
    json_response(@user)
  end

  def delete_player
    @game = Game.find(params[:game_id])
    if @game.status == "formation"
      @game_user = GameUser.find_by game_id: params[:game_id], user_id: params[:id]
      unless @game_user.nil?
        @game_user.destroy
        head :no_content
      else
        head :not_found
      end

    end

  end
end
