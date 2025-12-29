class UserChannelPreference < ApplicationRecord
  belongs_to :user

  enum :channel, {
    sms: 0,
    email: 1,
    push: 2
  }

  validates :channel, presence: true
  validates :user_id, uniqueness: { scope: :channel }
end
