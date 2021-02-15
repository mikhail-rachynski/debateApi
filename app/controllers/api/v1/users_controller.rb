class Api::V1::UsersController < ApplicationController

  def index
    @users = User.all.order(:id)
    # json_response(@users)
    render 'index.json.jbuilder'
  end

  def show
    @user = User.find(params[:id])
    render 'show.json.jbuilder'
    # json_response(@user)
  end

  def create
    @new_user = User.create(items_params)
    json_response(@new_user, :created)
  end

  def update
    @user = User.find(params[:id])
    @user.update(items_params)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
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

  private

  def items_params
    params.permit(:username )
  end

end
