module Broadcasts
  # Game
  def pub_game(action, game)
    ActionCable.server.broadcast(
        "chat_Games",
        {
            action: action,
            game: {
                id: game.id,
                topic: game.topic,
                status: game.status,
                time: game.created_at,
                users: game.users,
            }
        })
  end

  def pub_deleted_game_id(action, gameId)
    ActionCable.server.broadcast(
        "chat_Games",
        {
            action: action,
            gameId: gameId
        })
  end

  def pub_game_users(action, game)
    ActionCable.server.broadcast(
        "chat_Games",
        {
            action: action,
            gameId: game.id,
            users: game.users.map do |user|
              {id: user.id,
               name: user.name,
               role: user.game_users.find_by(game: game).role}
            end
        })
  end


  def pub_round_rating(action)
    ActionCable.server.broadcast(
        "chat_Game_#{@round.game.id}",
        {
            action: action,
            roundId: @round.id,
            rating: @round.rating
        })
  end

  def pub_status(action, game)
    ActionCable.server.broadcast(
        "chat_Game",
        {
            action: action,
            gameId: game.id,
            status: game.status
        })
  end

  def pub_started_round(action, round, duration)
    ActionCable.server.broadcast(
        "chat_Game_#{round.game.id}",
        {
            action: action,
            round: {
                id: round.id,
                game_id: round.game_id,
                created_at: round.created_at.to_i,
                updated_at: round.updated_at,
                round_type: round.round_type,
                rating: round.rating,
                team: round.team
            },
            duration: duration
        })
  end

  #Speeches
  def pub_speech(action, game_id, speech)
    ActionCable.server.broadcast(
        "chat_Game_#{game_id}",
        {
            action: action,
            speech: speech,
        })
  end

  # Notifications
  def pub_all_notifications(user, action="set_all_messages", offset=0)

    notifications = User.find(current_user.id).notifications
    portion = notifications.order(created_at: :desc).offset(offset).limit(15)

    NotificationsChannel.broadcast_to(
        user,
        {action: action,
         allMessagesCount: notifications.count,
         messages: portion.map do |item|
           {
               id: item.id,
               text: item.text,
               created_at: item.created_at,
               id: item.id,
               read: UsersNotification.find_by(notification_id: item.id).read
           }
         end
        })
  end

  def pub_notifications_count(user)
    count = User.find_by(id: user).notifications.unread.count
    NotificationsChannel.broadcast_to(
        user,
        {action: "unread_messages",
         count: count
        })
  end

  def pub_new_notification(user, message="")
    notifications = User.find_by(id: user.id).notifications
    NotificationsChannel.broadcast_to(
        user,
        {
            action: "set_new_message",
            allMessagesCount: notifications.count,
            count: notifications.unread.count,
            message: message
        })
  end

end