require "rails_helper"

RSpec.describe Notifications::SenderFactory do
  describe ".build" do
    it "returns SmsSender for sms" do
      sender = described_class.build(channel: "sms")
      expect(sender).to be_a(Notifications::Senders::SmsSender)
    end

    it "returns EmailSender for email" do
      sender = described_class.build(channel: "email")
      expect(sender).to be_a(Notifications::Senders::EmailSender)
    end

    it "returns PushSender for push" do
      sender = described_class.build(channel: "push")
      expect(sender).to be_a(Notifications::Senders::PushSender)
    end

    it "raises for unknown channel" do
      expect { described_class.build(channel: "fax") }
        .to raise_error(ArgumentError, /Unknown notification channel/)
    end
  end
end
