class MessagesWorker
  include Sidekiq::Worker

  def perform(message_id)
    message = Message.find(message_id)
    return if message.sent

    mail = Mail.new do 
      date    Time.now
      subject message.title
      to      message.emails
      html_part do 
        content_type 'text/html; charset=UTF-8'
        body message.body
      end
    end

    client = Google::APIClient.new
    client.authorization.access_token = Token.last.fresh_token
    service = client.discovered_api('gmail')

    client.execute(
      api_method: service.users.messages.to_h["gmail.users.messages.send"], #plain .send accesses Object#send
      body_object: { raw: Base64.urlsafe_encode64(mail.to_s) },
      parameters: { userId: 'me' }
    )
  end
end