class Round < ApplicationRecord
  enum round_type: [:first_faction_prime, :second_faction_leader,
                    :first_faction_deputy, :second_faction_deputy,
                    :third_faction_member, :fourth_faction_member,
                    :third_faction_whip, :fourth_faction_whip]

  enum team: [:government, :opposition]
  scope :government, -> {where(team: 0)}
  scope :opposition, -> {where(team: 1)}

  belongs_to :game
  has_many :speech, dependent: :destroy

  def set_rating(value)
    self.update(rating: value)
  end

  def set_round(rounds_count)
    self.round_type = Round.round_types.key(rounds_count)
    self.team = define_team(self.round_type)
    self.save
  end

  private
  def define_team(round_type)
    case round_type
    when Round.round_types.key(0),
        Round.round_types.key(2),
        Round.round_types.key(4),
        Round.round_types.key(6)
      0
    when Round.round_types.key(1),
        Round.round_types.key(3),
        Round.round_types.key(5),
        Round.round_types.key(7)
      1
    end
  end

end