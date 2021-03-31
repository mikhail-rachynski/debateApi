class Round < ApplicationRecord
  enum round_type: [:first_faction,
                    :second_faction,
                    :third_faction,
                    :fourth_faction]

  belongs_to :game
  has_many :speech, dependent: :destroy

  def set_rating(value)
    self.update(rating: value)
  end

  def set_round(rounds_count)
    self.round_type = Round.round_types.key(rounds_count)
    self.save
  end

end