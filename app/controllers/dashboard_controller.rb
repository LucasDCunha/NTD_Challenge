class DashboardController < ApplicationController
  PER_PAGE = 25

  def index
    @categories = Message.categories.keys
    @channels = NotificationLog.channels.keys
    @statuses = NotificationLog.statuses.keys

    @filter = {
      category: params[:category].presence,
      channel: params[:channel].presence,
      status: params[:status].presence,
    }

    logs = NotificationLog
      .includes(:user, :message)
      .references(:user, :message)
      .order(created_at: :desc)

    if @filter[:category].present?
      logs = logs.joins(:message).where(messages: { category: Message.categories.fetch(@filter[:category]) })
    end

    logs = logs.where(channel: NotificationLog.channels.fetch(@filter[:channel])) if @filter[:channel].present?
    logs = logs.where(status: NotificationLog.statuses.fetch(@filter[:status])) if @filter[:status].present?

    @notification_logs = logs.page(params[:page]).per(PER_PAGE)
  end
end