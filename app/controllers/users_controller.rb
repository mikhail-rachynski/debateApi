class UsersController < ApplicationController
  def index
    @text = "Стартовая страница"
  end

  def show
    @users = User.all.order(:id)
  end


end
