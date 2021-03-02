class GameUser < ApplicationRecord
  enum role: [:referee,
              :primeMinister, :deputyPrimeMinister,
              :leaderOpposition, :deputyLeaderOpposition,
              :memberGovernment, :governmentWhip,
              :memberOpposition, :oppositionWhip]
  
  belongs_to :user
  belongs_to :game

end
