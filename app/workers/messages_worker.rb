class MessagesWorker
  include Sidekiq::Worker

  def perform(message_id)
    message = Message.find_by_id(message_id)
    return if message.nil?
    message.deliver
  end
end