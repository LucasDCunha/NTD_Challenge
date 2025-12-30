class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)
    @message.body = @message.body.to_s.strip

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
    @message.body = @message.body.to_s.strip
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
    @channels = NotificationLog.channels.keys
    @statuses = NotificationLog.statuses.keys

    @notification_logs = NotificationLog
      .includes(:user, :message)
      .order(created_at: :desc)
      .page(params[:page])
      .per(DashboardController::PER_PAGE)
  end
end
