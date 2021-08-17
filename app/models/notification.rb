class Notification < ApplicationRecord
  has_many :users_notifications
  has_many :users, through: :users_notifications

  scope :unread, -> {joins(:users).merge(UsersNotification.where(read: false))}
  scope :read, -> {joins(:users_notifications).read}

end
