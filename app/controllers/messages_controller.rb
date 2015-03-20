class MessagesController < ApplicationController
  before_action :set_message, only: [:edit, :update, :autosave]

  def index
    redirect_to "/auth/google_oauth2"
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.create(message_params)

    if @message.valid?
      MessagesWorker.perform_in(@message.time_limit, @message.id, session["token_id"].to_i)
      redirect_to edit_message_url(@message)
    else 
      render 'new'
    end
  end

  def edit
  end

  def update
    @message.update!(message_params)
    puts "\n\n\n\n\nToken id: #{session['token_id']}\n\n\n\n\n\n"
    MessagesWorker.new.perform(@message.id, session["token_id"].to_i)
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