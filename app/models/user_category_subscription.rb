class UserCategorySubscription < ApplicationRecord
  belongs_to :user

  enum :category, {
    sports: 0,
    finance: 1,
    movies: 2
  }

  validates :category, presence: true
  validates :user_id, uniqueness: { scope: :category }
end
