module Wssender
  def sendGameUsersToWebSocket(action, game)
    ActionCable.server.broadcast(
        "chat_Games",
        {action: action,
         gameId: game.id,
         users: game.users.map do |user|
           {id: user.id,
            name: user.name,
            role: user.game_users.find_by(game: game).role}
         end
        })
  end

  def sendGameToWebSocket(action, game)
    ActionCable.server.broadcast(
        "chat_Games",
        {action: action,
         game: game
        })
  end

  def sendDeletedGameIdToWebSocket(action, gameId)
    ActionCable.server.broadcast(
        "chat_Games",
        {action: action,
         gameId: gameId
        })
  end

  def sendStarRatingToWebSocket(action)
    ActionCable.server.broadcast(
        "chat_Game_#{@round.game.id}",
        {action: action,
         roundId: @round.id,
         rating: @round.rating
        })
  end

  def sendStatusToWebSocket(action, game)
    ActionCable.server.broadcast(
        "chat_Game",
        {action: action,
         gameId: game.id,
         status: game.status
        })
  end

  def sendStartedRoundToWebSocket(action, round, duration)
    ActionCable.server.broadcast(
        "chat_Game_#{round.game.id}",
        {action: action,
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

end