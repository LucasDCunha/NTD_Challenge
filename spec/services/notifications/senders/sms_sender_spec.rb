require "rails_helper"

RSpec.describe Notifications::Senders::SmsSender do
  let(:sender) { described_class.new }
  let(:message) { build(:message) }

  it "returns true when phone_number is present" do
    user = build(:user, phone_number: "+5511999990000")
    expect(sender.send!(user: user, message: message)).to eq(true)
  end

  it "raises when phone_number is missing" do
    user = build(:user, phone_number: nil)
    expect { sender.send!(user: user, message: message) }
      .to raise_error(ArgumentError, /Missing required user field: phone_number/)
  end
end
