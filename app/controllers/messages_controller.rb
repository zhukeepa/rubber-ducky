class MessagesController < ApplicationController
  def new
  end

  def write
    @message = Message.new(message_params)
  end

  def send_message
    render text: message_params
  end

private
  def message_params 
    params.permit(:title, :timer, :emails, :body)
  end
end
