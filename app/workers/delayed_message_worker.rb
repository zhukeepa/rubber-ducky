class DelayedMessageWorker
  include Sidekiq::Worker

  def perform(id)
    # j_id
    message = Message.find_by_id(id)
    message && !message.sent && MessagesMailer.email(id).deliver_now
  end
end