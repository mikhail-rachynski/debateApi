class GameUser < ApplicationRecord
  enum role: [:player, :referee]
  belongs_to :user
  belongs_to :game

end
