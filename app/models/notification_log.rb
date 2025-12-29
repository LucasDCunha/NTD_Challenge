class NotificationLog < ApplicationRecord
  belongs_to :message
  belongs_to :user

  enum :channel, {
    sms: 0,
    email: 1,
    push: 2
  }

  enum :status, {
    pending: 0,
    sent: 1,
    failed: 2,
    skipped: 3
  }

  validates :channel, presence: true
  validates :status, presence: true
end
