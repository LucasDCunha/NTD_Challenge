FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "User #{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    sequence(:phone_number) { |n| "+551199999#{format('%04d', n)}" }
  end
end
