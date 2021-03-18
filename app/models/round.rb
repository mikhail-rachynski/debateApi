class Round < ApplicationRecord
  enum round_type: [:first_faction, :second_faction, :third_faction, :fourth_faction]

  belongs_to :game
  has_many :speech, dependent: :destroy
end