class MessagesController < ApplicationController
  def new
    @message = Message.new
    load_form_context
  end

  def create
    @message = Message.new(message_params)
    @message.body = @message.body.to_s.strip

    if @message.invalid?
      load_form_context
      return render :new, status: :unprocessable_entity
    end

    Messages::CreateAndDispatch.new(
      category: @message.category,
      body: @message.body
    ).call

    redirect_to root_path, notice: "Message sent and notifications dispatched."
  rescue ActiveRecord::RecordInvalid => e
    @message ||= Message.new(message_params)
    @message.body = @message.body.to_s.strip
    @message.errors.add(:base, e.record.errors.full_messages.to_sentence)

    load_form_context
    render :new, status: :unprocessable_entity
  rescue StandardError => e
    @message ||= Message.new(message_params)
    @message.body = @message.body.to_s.strip
    @message.errors.add(:base, "Unexpected error while dispatching: #{e.message}")

    load_form_context
    render :new, status: :unprocessable_entity
  end

  private

  def message_params
    params.require(:message).permit(:category, :body)
  end

  def load_form_context
    @categories = Message.categories.keys
  end
end
