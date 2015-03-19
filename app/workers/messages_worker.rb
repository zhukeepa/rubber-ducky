class MessagesWorker
  include Sidekiq::Worker

  def perform(id)
    messsage = Message.find(id)
    return if messsage.sent

    client = Google::APIClient.new
    client.authorization.access_token = Token.last.fresh_token
    service = client.discovered_api('gmail')

    msg          = Mail.new
    msg.date     = Time.now
    msg.subject  = messsage.title
    msg.to       = messsage.emails
    msg.html_part do 
      content_type 'text/html; charset=UTF-8'
      body messsage.body
    end

    @email = client.execute(
        api_method: service.users.messages.to_h["gmail.users.messages.send"], 
        body_object: { raw: Base64.urlsafe_encode64(msg.to_s) },
        parameters: { userId: 'me' }
    )

    puts "\n\n\n\n\n#{@email.inspect}\n\n\n\n\n"
  end
end