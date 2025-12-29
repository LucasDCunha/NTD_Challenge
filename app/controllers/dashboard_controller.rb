class DashboardController < ApplicationController
  def index
    @categories = Message.categories.keys
    @notification_logs = NotificationLog
      .includes(:user, :message)
      .order(created_at: :desc)
      .limit(200)
  end
end
