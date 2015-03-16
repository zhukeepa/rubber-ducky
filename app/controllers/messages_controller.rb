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

  # implement autosave
  # refactoring ??? 
  # seems to be sending message, like, 3 times
  # add OAunth or something?? 
  # fix forms. 
  # take time_limit out of messages. 
  # passing in hidden_field_tag

private
  def message_params 
    params[:message].permit(:title, :time_limit, :emails, :body)
  end
end
