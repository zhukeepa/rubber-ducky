class MessageWorker
  include Sidekiq::Worker

  def perform(name, count)
    puts 'Doing hard work'
  end
end

class MessagesController < ApplicationController
  before_action :set_message, only: [:edit, :update, :autosave]
  
  def new
    @message = Message.new
  end

  def create
    @message = Message.create!(message_params)
    MessagesMailer.email(@message).deliver_later(wait: @message.time_limit)

    redirect_to edit_message_url(@message)
  end

  def edit
  end

  def update
    @message.update!(message_params)
    MessageWorker.perform_in 3.seconds, "hello", 24
    ActionMailer::MessageDelivery.new(MessagesMailer, :email, @message).deliver_later
#    MessagesMailer.email(@message).deliver_later
    @message.update(sent: true)

    redirect_to root_url, notice: "Message sent!"
  end

  def autosave
    @message.update(message_params)

    render text: params
  end

  def fail
    redirect_to root_url, notice: "You failed! Whatever message was in the textbox got sent."
  end

private
  def message_params 
    params[:message].permit(:title, :time_limit, :emails, :body)
  end

  def set_message
    @message = Message.find(params[:id])
  end
end