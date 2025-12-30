module Notifications
  module Senders
    class BaseSender
      def send!(user:, message:)
        raise NotImplementedError, "#{self.class} must implement #send!"
      end

      private

      def ensure_present!(value, field_name)
        return if value.present?

        raise ArgumentError, "Missing required user field: #{field_name}"
      end
    end
  end
end
