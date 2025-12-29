class MessagesController < ApplicationController
  def create
    message = Messages::CreateAndDispatch.new(
      category: message_params[:category],
      body: message_params[:body]
    ).call

    redirect_to root_path, notice: "Message created (##{message.id}) and notifications dispatched."
  rescue ActiveRecord::RecordInvalid => e
    redirect_to root_path, alert: e.record.errors.full_messages.to_sentence
  rescue StandardError => e
    # Fault-tolerance: se der erro inesperado, mostra algo genérico
    redirect_to root_path, alert: "Unexpected error while dispatching: #{e.message}"
  end

  private

  def message_params
    params.require(:message).permit(:category, :body)
  end
end
