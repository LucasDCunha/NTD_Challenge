FactoryBot.define do
  factory :user_channel_preference do
    user
    channel { :email }
  end
end
