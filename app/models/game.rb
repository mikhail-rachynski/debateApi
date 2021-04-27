class Game < ApplicationRecord
  enum status: [:waiting, :progress, :pause, :finished]

  has_many :game_users, dependent: :destroy
  has_many :users, through: :game_users
  belongs_to :user

  has_many :rounds, dependent: :destroy

  def add_player(current_user)
    player_limit = 9
    find_duplicate_user = self.users.find_by id: current_user
    if find_duplicate_user.nil?
      if self.users.count < player_limit && self.status == Game.statuses.key(0)
        GameUser.create(game: self, user_id: current_user)
        start_game if self.users.count == player_limit
        return @games = Game.all.order(:id)
      else
        @error = "Players limit reached"
        render 'api/v1/errors/error.json.jbuilder'
      end
    else
      @error = "User has already been added"
      render 'api/v1/errors/error.json.jbuilder'
    end
  end

  def delete_player(current_user)
    if self.status == Game.statuses.key(0)
      @game_user = GameUser.find_by game_id: self.id, user_id: current_user
      unless @game_user.nil?
        @game_user.destroy
      end
    end
  end

  def set_users_roles
    count = 0
    random_roles = GameUser.roles.to_a.shuffle
    GameUser.where(game_id: self.id).find_each do |item|
      item.update(role: random_roles[count][0])
      count += 1
    end
  end

  def start_game
    set_users_roles
    play_round(self)
    self.update(status: 1)
  end

  def play_round(game)
    thisGame = Game.find(game.id)
    rounds_count = thisGame.rounds.length
    if rounds_count < 8
      Round.new(game: thisGame).set_round(rounds_count)
      Thread.new do
        round_duration = 3
        end_time = Time.now.to_i+round_duration
        while true
          if Time.now.to_i > end_time
            play_round(thisGame)
            break
          end
          sleep 1
        end
      end
    elsif rounds_count == 8
      self.update(status: 3)
    end
  end

end
