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
end
