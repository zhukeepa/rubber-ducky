class GoogleMailer < Google::APIClient
  def self.deliver(message, access_token)
    new(access_token).deliver(message)
  end

  def initialize(access_token)
    super()
    self.authorization.access_token = access_token
  end 

  def deliver(message)
    execute(api_method: send_api_method,
            body_object: { raw: Base64.urlsafe_encode64(message) },
            parameters: { userId: 'me' })
  end

private 

  def send_api_method
    discovered_api('gmail').users.messages.to_h["gmail.users.messages.send"] # don't want Object#send
  end
end