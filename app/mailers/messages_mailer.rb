class MessagesMailer < ApplicationMailer
  def email(id)
    message = Message.find(id)
    @body = message.body
    mail(from: "alex.zhu.1994@gmail.com", to: message.emails, subject: message.title)
  end
end
