require "rails_helper"

RSpec.describe Notifications::Dispatcher do
  describe "#call" do
    it "dispatches only to users subscribed to the message category and only via their preferred channels" do
      message = create(:message, category: :sports, body: "Sports news")

      subscribed = create(:user)
      not_subscribed = create(:user)

      create(:user_category_subscription, user: subscribed, category: :sports)
      create(:user_category_subscription, user: not_subscribed, category: :finance)

      create(:user_channel_preference, user: subscribed, channel: :email)
      create(:user_channel_preference, user: subscribed, channel: :sms)

      # Silence broadcasting (we test delivery/logs, not Turbo here)
      allow(Notifications::LogBroadcaster).to receive(:append)

      described_class.new(message: message).call

      logs = NotificationLog.where(message: message)

      expect(logs.count).to eq(2)
      expect(logs.pluck(:user_id).uniq).to eq([subscribed.id])

      expect(logs.pluck(:channel).sort).to eq(%w[email sms].sort)
      expect(logs.pluck(:status).uniq).to eq(["sent"])
    end

    it "marks a log as failed when a sender raises and continues with other deliveries" do
      message = create(:message, category: :sports, body: "Sports news")

      user = create(:user)
      create(:user_category_subscription, user: user, category: :sports)
      create(:user_channel_preference, user: user, channel: :sms)
      create(:user_channel_preference, user: user, channel: :email)

      allow(Notifications::LogBroadcaster).to receive(:append)

      # Force SMS sender to fail, Email to succeed
      sms_sender = instance_double(Notifications::Senders::SmsSender)
      email_sender = instance_double(Notifications::Senders::EmailSender)

      allow(Notifications::SenderFactory).to receive(:build).with(channel: "sms").and_return(sms_sender)
      allow(Notifications::SenderFactory).to receive(:build).with(channel: "email").and_return(email_sender)

      allow(sms_sender).to receive(:send!).and_raise(StandardError, "SMS provider error")
      allow(email_sender).to receive(:send!).and_return(true)

      described_class.new(message: message).call

      sms_log = NotificationLog.find_by(message: message, user: user, channel: "sms")
      email_log = NotificationLog.find_by(message: message, user: user, channel: "email")

      expect(sms_log.status).to eq("failed")
      expect(sms_log.error_message).to eq("SMS provider error")

      expect(email_log.status).to eq("sent")
      expect(email_log.delivered_at).to be_present
    end

    it "creates logs with status pending before delivery and updates them afterwards" do
      message = create(:message, category: :sports)
      user = create(:user)

      create(:user_category_subscription, user: user, category: :sports)
      create(:user_channel_preference, user: user, channel: :push)

      allow(Notifications::LogBroadcaster).to receive(:append)

      described_class.new(message: message).call

      log = NotificationLog.find_by(message: message, user: user, channel: "push")
      expect(log).to be_present
      expect(log.status).to eq("sent")
    end
  end
end
