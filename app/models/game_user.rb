class GameUser < ApplicationRecord
  enum role: [:referee,
              :prime_minister, :deputy_prime_minister,
              :leader_opposition, :deputy_leader_opposition,
              :member_government, :government_whip,
              :member_opposition, :opposition_whip]

  belongs_to :user
  belongs_to :game

end
