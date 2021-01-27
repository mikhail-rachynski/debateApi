class User < ApplicationRecord
  validates :username, presence: true

  has_many :game_users
  has_many :games, through: :game_users
end
