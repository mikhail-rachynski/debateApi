class User < ApplicationRecord
  validates :username, presence: true

  has_many :game_users
  has_many :games, through: :game_users

  scope :users_player, -> {joins(:games).merge(GameUser.player)}
  scope :users_referee, -> {joins(:games).merge(GameUser.referee)}
end
