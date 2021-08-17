class Game < ApplicationRecord
  enum status: [:waiting, :progress, :pause, :finished]

  has_many :game_users, dependent: :destroy
  has_many :users, through: :game_users
  belongs_to :user
  has_many :rounds, dependent: :destroy

  def speeches
    self.rounds.map {|round| round.speeches}
  end

  def add_player(current_user)
    players_limit = 9
    find_duplicate_user = self.users.find_by id: current_user.id
    if find_duplicate_user.nil?
      if self.users.count < players_limit && self.status == Game.statuses.key(0)
        GameUser.create(game: self, user_id: current_user.id)
        start_game current_user if self.users.count == players_limit
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

  def start_game(current_user)
    set_users_roles
    play_round(self)
    self.update(status: 1)
    notification = Notification.create(text: "Game #{self.topic} started")
    self.users.map do |user|
      UsersNotification.create(user_id: user.id, notification: notification)
      pub_new_notification current_user, notification if current_user.id === user.id
    end

    pub_status "set_start_game_status", self
  end

  def play_round(game)
    thisGame = Game.find(game.id)
    rounds_count = thisGame.rounds.length
    round_duration = 300

    if rounds_count < 8
      round = Round.new(game: thisGame)
      round.set_round(rounds_count)
      pub_started_round "round_start", round, round_duration
      Thread.new do
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
      pub_status "set_finish_game_status", thisGame
    end
  end

end
