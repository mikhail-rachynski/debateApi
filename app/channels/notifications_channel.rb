class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_for current_user
    pub_notifications_count current_user
  end

  def get_notifications
    pub_all_notifications current_user
  end

  def read_notifications
    UsersNotification.where(user_id: current_user.id).map {|item| item.update(read: true)}
    pub_notifications_count current_user
  end

  def add_notifications(data)
    pub_all_notifications current_user, "add_new_notifications_to_list", data["count"]
  end
end
