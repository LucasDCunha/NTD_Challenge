class Message < ApplicationRecord
  enum :category, {
    sports: 0,
    finance: 1,
    movies: 2
  }

  validates :category, presence: true
  validates :body, presence: true
end
