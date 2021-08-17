module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect

      self.current_user = find_verified_user

    end

    private
    def find_verified_user
      access_token = request.query_parameters()["token"]
      unless access_token === ""
        user_id = JWT.decode(access_token, Rails.application.secrets.secret_key_base).first['id']
      end

      if verified_user = User.find_by(id: user_id)
        verified_user
      else
        # reject_unauthorized_connection
      end
    end
  end
end