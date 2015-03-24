class MessagesController < ApplicationController
  before_action :set_message, only: [:edit, :update, :autosave]

  def index
    redirect_to "/auth/google_oauth2"
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.create(message_params.merge(token_id: session['token_id']))

    if @message.valid?
      MessagesWorker.perform_in(@message.time_limit, @message.id)
      redirect_to compose_messages_url
    else 
      render 'new'
    end
  end

  def compose
    @message = Token.find(session['token_id']).messages.last
  end

  def update
    @message.update!(message_params)
    MessagesWorker.new.perform(@message.id)
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