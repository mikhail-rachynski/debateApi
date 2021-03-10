class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy, :update]

  def index
    @users = User.all.order(:id)
    # json_response(@users)
    render 'index.json.jbuilder'
  end

  def show
    @user = User.find(params[:id])
    render 'show.json.jbuilder'
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

  private

  def items_params
    params.permit(:username )
  end

end
