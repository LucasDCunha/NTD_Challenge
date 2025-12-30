class Message < ApplicationRecord
  enum :category, {
    sports: 0,
    finance: 1,
    movies: 2
  }

  validates :category, presence: true
  validate :body_must_be_present

  private

  def body_must_be_present
    return if body.to_s.strip.present?

    errors.add(:body, "cannot be blank")
  end
end