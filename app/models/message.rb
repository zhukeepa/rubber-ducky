# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  title      :string
#  body       :string
#  emails     :string
#  time_limit :integer
#  sent       :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  token_id   :integer
#

class Message < ActiveRecord::Base
  validates :title, :time_limit, :emails, presence: true
  validates :emails, format: { with: /\A([\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+(,?)\s*)+\z/i, 
    message: "invalid email list" }

  belongs_to :token

  def time_limit=(time_limit)
    write_attribute(:time_limit, time_limit.to_i*60)
  end

  def deliver
    GoogleMailer.deliver(email_string, token.fresh_token)
    destroy
  end

private 
  def email_string
    message = self
    Mail.new do 
      date    Time.now
      subject message.title
      to      message.emails
      html_part do 
        content_type 'text/html; charset=UTF-8'
        body          message.body
      end
    end.to_s
  end 
end

