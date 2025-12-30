require "rails_helper"

RSpec.describe Notifications::Senders::EmailSender do
  let(:sender) { described_class.new }
  let(:message) { build(:message) }

  it "returns true when email is present" do
    user = build(:user, email: "test@example.com")
    expect(sender.send!(user: user, message: message)).to eq(true)
  end

  it "raises when email is missing" do
    user = build(:user, email: nil)
    expect { sender.send!(user: user, message: message) }
      .to raise_error(ArgumentError, /Missing required user field: email/)
  end
end
