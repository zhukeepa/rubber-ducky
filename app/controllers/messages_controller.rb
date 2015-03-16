class MessagesController < ApplicationController
  def new
  end

  def write
    @message = Message.new(message_params)
    @message.sent = false
    @message.save
    DelayedMessageWorker.perform_in(@message.time_limit.seconds, @message.id)
  end

  def send_message
    @message = Message.find(params[:id])
    @message.update(body: params[:body], sent: true)

    MessagesMailer.email(@message.id).deliver_now
    render text: "Email sent!"
  end

  def autosave
    @message = Message.find(params[:id])
    @message.update(body: params[:body])
    render text: ''
  end

  def fail
    render text: "You failed! Whatever message was in the textbox got sent."
  end

private
  def message_params 
    params[:message].permit(:title, :time_limit, :emails, :body)
  end
end
