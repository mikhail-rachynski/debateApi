module ApplicationCable
  class Channel < ActionCable::Channel::Base
    include Broadcasts
  end
end
