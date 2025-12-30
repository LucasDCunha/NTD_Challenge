require "rails_helper"

RSpec.describe Notifications::LogBroadcaster do
  describe ".append" do
    it "broadcasts append and removes empty state" do
      log = instance_double(NotificationLog)

      allow(described_class).to receive(:render_row).with(log).and_return("<tr>row</tr>")

      expect(Turbo::StreamsChannel).to receive(:broadcast_append_to).with(
        "notification_logs",
        target: "notification_logs_rows",
        html: "<tr>row</tr>"
      )

      expect(Turbo::StreamsChannel).to receive(:broadcast_remove_to).with(
        "notification_logs",
        target: "notification_logs_empty_state"
      )

      described_class.append(log)
    end
  end
end
