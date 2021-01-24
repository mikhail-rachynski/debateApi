class User < ApplicationRecord
  validates :username, presence: true

  has_one :book, dependent: :destroy
end
