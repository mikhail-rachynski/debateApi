class Game < ApplicationRecord
  enum kind: [:formation, :progress, :break, :finished]

  has_many :game_users
  has_many :users, through: :game_users
end
