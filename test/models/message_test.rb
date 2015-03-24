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

require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  test "email setter should return list of emails from comma-separated" do
    message = Message.new(emails: "alex@example.com  , damien@example.org  ")
    assert_equal ["alex@example.com", "damien@example.org"], message.emails
  end

  test "time limit should be converted to seconds" do 
    message = Message.new(time_limit: 1)
    assert_equal 60, message.time_limit
  end
end
