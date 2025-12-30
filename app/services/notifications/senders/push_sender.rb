module Notifications
  module Senders
    class PushSender < BaseSender
      def send!(user:, message:)
        Rails.logger.info("[PUSH] ToUserID=#{user.id} | Category=#{message.category} | Body=#{message.body}")

        true
      end
    end
  end
end
