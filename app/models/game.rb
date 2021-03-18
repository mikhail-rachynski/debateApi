class Game < ApplicationRecord
  enum status: [:waiting, :progress, :pause, :finished]

  has_many :game_users, dependent: :destroy
  has_many :users, through: :game_users
  belongs_to :user

  has_many :rounds, dependent: :destroy
end
