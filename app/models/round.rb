class Round < ApplicationRecord
  belongs_to :game
  has_many :speech
end