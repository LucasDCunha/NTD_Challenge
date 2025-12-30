require "rails_helper"

RSpec.describe Messages::CreateAndDispatch do
  describe "#call" do
    it "creates a message and dispatches notifications" do
      dispatcher = instance_double(Notifications::Dispatcher)

      expect(Notifications::Dispatcher).to receive(:new).and_return(dispatcher)
      expect(dispatcher).to receive(:call)

      service = described_class.new(category: "sports", body: "Hello")
      message = service.call

      expect(message).to be_persisted
      expect(message.category).to eq("sports")
      expect(message.body).to eq("Hello")
    end

    it "raises ActiveRecord::RecordInvalid when message is invalid" do
      service = described_class.new(category: "sports", body: "   ")

      expect { service.call }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
