module Notifications
  class SenderFactory
    def self.build(channel:)
      case channel.to_s
      when "sms"   then Notifications::Senders::SmsSender.new
      when "email" then Notifications::Senders::EmailSender.new
      when "push"  then Notifications::Senders::PushSender.new
      else
        raise ArgumentError, "Unknown notification channel: #{channel.inspect}"
      end
    end
  end
end
