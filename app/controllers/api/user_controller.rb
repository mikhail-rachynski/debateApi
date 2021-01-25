class Api::UserController < ApplicationController
  def index
    @text = "Стартовая страница"
  end

  # C-reate
  def create

  end

  def new

  end
  # R-ead
  def show

    @users = User.all.order(:id)
  end

  # U-pdate
  def edit

  end

  def update

  end
  # D-elete
  def delete

  end
end
