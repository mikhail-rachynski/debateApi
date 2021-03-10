class ChatChannel < ApplicationCable::Channel
  def subscribed
    game = Game.last
    stream_for game
  end
end
