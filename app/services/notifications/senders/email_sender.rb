module Notifications
  module Senders
    class EmailSender < BaseSender
      def send!(user:, message:)
        ensure_present!(user.email, :email)

        Rails.logger.info("[EMAIL] To=#{user.email} | Category=#{message.category} | Body=#{message.body}")

        true
      end
    end
  end
end
