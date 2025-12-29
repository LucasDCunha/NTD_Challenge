module Notifications
  module Senders
    class PushSender < BaseSender
      def send!(user:, message:)
        # No desafio não existe "device token", então só simulamos.
        # Se no futuro você adicionar device_token, valida aqui.
        Rails.logger.info("[PUSH] ToUserID=#{user.id} | Category=#{message.category} | Body=#{message.body}")

        true
      end
    end
  end
end
