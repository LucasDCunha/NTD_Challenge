module Notifications
  class Dispatcher
    def initialize(message:)
      @message = message
    end

    def call
      recipients.find_each do |user|
        channels_for(user).each do |channel|
          deliver_to(user: user, channel: channel)
        end
      end
    end

    private

    attr_reader :message

    def recipients
      Notifications::RecipientsResolver.new(category: message.category).call
    end

    def channels_for(user)
      user.user_channel_preferences.pluck(:channel).map do |raw|
        raw.is_a?(Integer) ? UserChannelPreference.channels.key(raw) : raw.to_s
      end
    end

    def deliver_to(user:, channel:)
      log = NotificationLog.create!(
        message: message,
        user: user,
        channel: channel,
        status: :pending
      )

      sender = Notifications::SenderFactory.build(channel: channel)

      sender.send!(user: user, message: message)

      log.update!(
        status: :sent,
        delivered_at: Time.current,
        error_message: nil
      )

      Notifications::LogBroadcaster.append(log)
    rescue StandardError => e
      log&.update!(
        status: :failed,
        error_message: e.message
      )

      Notifications::LogBroadcaster.append(log) if log.present?
    end
  end
end
