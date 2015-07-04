# == Schema Information
#
# Table name: messages
#
#  id              :integer          not null, primary key
#  title           :string
#  body            :string
#  emails          :string
#  time_limit      :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  token_id        :integer
#  debug           :boolean
#  debug_form      :boolean
#  reflection_form :boolean
#  form_load       :string
#

class Message < ActiveRecord::Base
  validates :title, :time_limit, :emails, presence: true
  validates :emails, format: { with: /\A([\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+(,?)\s*)+\z/i, 
    message: "invalid email list" }

  belongs_to :token

  def initialize(*args)
    super

    load_form
  end

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

  def load_form
    return unless self.form_load

    filename = "#{self.form_load}_form.html"
    filename_full = File.join(Rails.root, 'lib', 'assets', filename)
    self.body = File.read(filename_full)
  end
end

