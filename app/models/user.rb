class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :recoverable, :rememberable, :validatable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable

  def generate_jwt
    JWT.encode({id: id, exp: 60.days.from_now.to_i}, Rails.application.secrets.secret_key_base)
  end

  has_many :game_users, dependent: :destroy
  has_many :games, through: :game_users
  has_many :speeches, dependent: :destroy

  scope :player, -> {joins(:games).merge(GameUser.player)}
  scope :referee, -> {joins(:games).merge(GameUser.referee)}
end
