FactoryBot.define do
  factory :user_category_subscription do
    user
    category { :sports }
  end
end
