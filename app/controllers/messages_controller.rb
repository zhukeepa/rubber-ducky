class MessagesController < ApplicationController
  before_action :authenticate
  before_action :set_message, only: [:edit, :update, :send_message]


  if Rails.env.test?
    prepend_before_action :set_token_id
    def set_token_id
      session[:token_id] = ENV['TOKEN_ID']
    end
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params.merge(token_id: session[:token_id]))

    if @message.save
      MessagesWorker.perform_in(@message.time_limit, @message.id)
      session[:message_id] = @message.id 
      redirect_to compose_messages_url
    else 
      render 'new'
    end
  end

  def compose
    @message = Message.find(session[:message_id])
  end

  def send_message
    @message.update!(message_params)
    @message.deliver

    session[:message_id] = ''

    redirect_to root_url, notice: "Message sent!"
  end

  def update
    @message.update(message_params)

    render text: params
  end

  def fail
    redirect_to root_url, notice: "You failed! Whatever message was in the textbox got sent."
  end

private
  def authenticate
    redirect_to "/auth/google_oauth2" unless session[:token_id]
  end

  def message_params 
    params[:message].permit(:title, :time_limit, :emails, :body, :form_load)
  end

  def set_message
    @message = Message.find(params[:id])
  end
end