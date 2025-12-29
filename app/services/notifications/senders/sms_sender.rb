module Notifications
  module Senders
    class SmsSender < BaseSender
      def send!(user:, message:)
        ensure_present!(user.phone_number, :phone_number)

        # Simulação (sem integração real).
        Rails.logger.info("[SMS] To=#{user.phone_number} | Category=#{message.category} | Body=#{message.body}")

        true
      end
    end
  end
end
