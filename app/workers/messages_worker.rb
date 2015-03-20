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

#    t = session[:token_info]
#    token = Token.create(access_token: t["access_token"], refresh_token: t["refresh_token"], expires_at: t["expires_at"])

    client = Google::APIClient.new
    client.authorization.access_token = session[:access_token]
    service = client.discovered_api('gmail')

    client.execute(
      api_method: service.users.messages.to_h["gmail.users.messages.send"], # don't want Object#send
      body_object: { raw: Base64.urlsafe_encode64(mail.to_s) },
      parameters: { userId: 'me' }
    )
  end
end