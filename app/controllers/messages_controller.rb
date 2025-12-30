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

      respond_to do |format|
        format.turbo_stream
        format.html { render :new, status: :unprocessable_entity }
      end

      return
    end

    Messages::CreateAndDispatch.new(
      category: @message.category,
      body: @message.body
    ).call

    flash.now[:notice] = "Message sent and notifications dispatched."
    @message = Message.new
    load_form_context

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path, notice: "Message sent and notifications dispatched." }
    end
  rescue ActiveRecord::RecordInvalid => e
    @message ||= Message.new(message_params)
    @message.body = @message.body.to_s.strip
    @message.errors.add(:base, e.record.errors.full_messages.to_sentence)
    load_form_context

    respond_to do |format|
      format.turbo_stream
      format.html { render :new, status: :unprocessable_entity }
    end
  rescue StandardError => e
    @message ||= Message.new(message_params)
    @message.body = @message.body.to_s.strip
    @message.errors.add(:base, "Unexpected error while dispatching: #{e.message}")
    load_form_context

    respond_to do |format|
      format.turbo_stream
      format.html { render :new, status: :unprocessable_entity }
    end
  end

  private

  def message_params
    params.require(:message).permit(:category, :body)
  end

  def load_form_context
    @categories = Message.categories.keys
  end
end
