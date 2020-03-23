class MessagesController < ApplicationController
  skip_before_action :authenticate, only: %i[index show]

  def index
    @messages = Message.all
  end

  def show
    @message = Message.find_by(id: params[:id])
    render json: { errors: 'message not found' }, status: :not_found if @message.blank?
  end

  def create
    message = current_user.messages.new(message_params)

    if message.save
      render json: {}, status: :created
    end
  end

  private

  def message_params
    params.require(:message).permit(:text)
  end
end
