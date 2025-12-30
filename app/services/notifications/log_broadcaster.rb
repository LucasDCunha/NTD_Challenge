module Notifications
  class LogBroadcaster
    STREAM = "notification_logs"
    TARGET = "notification_logs_rows"

    def self.append(log)
      Turbo::StreamsChannel.broadcast_append_to(
        STREAM,
        target: TARGET,
        html: render_row(log)
      )

      Turbo::StreamsChannel.broadcast_remove_to(
        STREAM,
        target: "notification_logs_empty_state"
      )
    end

    def self.render_row(log)
      ApplicationController.renderer.render(
        partial: "dashboard/log_row",
        locals: { log: log }
      )
    end
  end
end
