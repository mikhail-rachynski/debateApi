class Round < ApplicationRecord
  belongs_to :game
  has_one :speech
end