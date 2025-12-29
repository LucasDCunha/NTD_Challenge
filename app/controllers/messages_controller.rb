class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)

    # Isso valida com os mesmos validators do model (antes de chamar o service)
    if @message.invalid?
      load_dashboard
      return render "dashboard/index", status: :unprocessable_entity
    end

    Messages::CreateAndDispatch.new(
      category: @message.category,
      body: @message.body
    ).call

    redirect_to root_path, notice: "Message sent and notifications dispatched."
  rescue StandardError => e
    @message ||= Message.new(message_params)
    @message.errors.add(:base, "Unexpected error while dispatching: #{e.message}")

    load_dashboard
    render "dashboard/index", status: :unprocessable_entity
  end

  private

  def message_params
    params.require(:message).permit(:category, :body)
  end

  def load_dashboard
    @categories = Message.categories.keys
    @notification_logs = NotificationLog
      .includes(:user, :message)
      .order(created_at: :desc)
      .limit(200)
  end
end
