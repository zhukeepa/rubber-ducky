class MessagesMailer < ApplicationMailer
  def email(message)
ddfsa sdfas dfsa dfadfdd
    return if message.sent

    @message = message
    mail(from: "alex.zhu.1994@gmail.com", to: @message.emails, subject: @message.title)
  end
end