puts "Limpando dados..."
NotificationLog.delete_all
UserCategorySubscription.delete_all
UserChannelPreference.delete_all
Message.delete_all
User.delete_all

puts "Criando usuários..."

users = [
  {
    name: "Alice",
    email: "alice@example.com",
    phone_number: "+5511999991111",
    categories: [:sports],
    channels: [:email]
  },
  {
    name: "Bob",
    email: "bob@example.com",
    phone_number: "+5511999992222",
    categories: [:finance],
    channels: [:sms]
  },
  {
    name: "Carol",
    email: "carol@example.com",
    phone_number: "+5511999993333",
    categories: [:movies],
    channels: [:push]
  },
  {
    name: "Dave",
    email: "dave@example.com",
    phone_number: "+5511999994444",
    categories: [:sports, :finance],
    channels: [:email, :sms]
  },
  {
    name: "Eve",
    email: "eve@example.com",
    phone_number: "+5511999995555",
    categories: [:sports, :finance, :movies],
    channels: [:email, :sms, :push]
  }
]

users.each do |data|
  user = User.create!(
    name: data[:name],
    email: data[:email],
    phone_number: data[:phone_number]
  )

  data[:categories].each do |category|
    UserCategorySubscription.create!(
      user: user,
      category: category
    )
  end

  data[:channels].each do |channel|
    UserChannelPreference.create!(
      user: user,
      channel: channel
    )
  end
end

puts "Seed finalizada com sucesso!"
puts "Usuários criados: #{User.count}"
puts "Subscriptions criadas: #{UserCategorySubscription.count}"
puts "Channel preferences criadas: #{UserChannelPreference.count}"
