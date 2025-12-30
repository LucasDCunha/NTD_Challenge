module Messages
  class CreateAndDispatch
    def initialize(category:, body:)
      @category = category
      @body = body
    end

    def call
      message = Message.create!(
        category: category,
        body: body
      )

      Notifications::Dispatcher.new(message: message).call

      message
    end

    private

    attr_reader :category, :body
  end
end
