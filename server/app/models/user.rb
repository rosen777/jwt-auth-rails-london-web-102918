class User < ApplicationRecord
  has_secure_password
  has_many :events
  has_many :user_events
  has_many :events, through: :user_events

  validates :username, uniqueness: { case_sensitive: false }
end
