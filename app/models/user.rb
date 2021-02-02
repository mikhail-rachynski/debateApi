class User < ApplicationRecord
  validates :username, presence: true

  has_many :game_users
  has_many :games, through: :game_users

  scope :player, -> {joins(:games).merge(GameUser.player)}
  scope :referee, -> {joins(:games).merge(GameUser.referee)}
end
