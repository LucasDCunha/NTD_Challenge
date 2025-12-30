require "rails_helper"

RSpec.describe Notifications::Senders::PushSender do
  let(:sender) { described_class.new }
  let(:message) { build(:message) }

  it "returns true (push is simulated)" do
    user = build(:user)
    expect(sender.send!(user: user, message: message)).to eq(true)
  end
end
