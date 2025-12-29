class User < ApplicationRecord
  has_many :user_category_subscriptions, dependent: :destroy
  has_many :user_channel_preferences, dependent: :destroy
  has_many :notification_logs, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true
  validates :phone_number, presence: true
end
