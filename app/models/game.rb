class Game < ApplicationRecord
  enum status: [:formation, :progress, :break, :finished]

  has_many :game_users, dependent: :destroy
  has_many :users, through: :game_users

  has_many :rounds, dependent: :destroy
end
