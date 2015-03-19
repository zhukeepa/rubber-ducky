# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  title      :string
#  body       :string
#  emails     :string
#  time_limit :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  sent       :boolean
#

class Message < ActiveRecord::Base
  validates :title, :time_limit, :emails, presence: true
  validates :emails, format: { with: /\A([\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+(,?)\s*)+\z/i, 
    message: "invalid email list" }

  def time_limit=(time_limit)
    write_attribute(:time_limit, time_limit.to_i*60)
  end
end
