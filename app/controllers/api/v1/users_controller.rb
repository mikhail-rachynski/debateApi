class Api::V1::UsersController < ApplicationController

  def index
    @users = User.all.order(:id)
    json_response(@users)

  end

  def show
    @user = User.find(params[:id])
    json_response(@user)
  end
end
