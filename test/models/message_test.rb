require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  test "email setter should return list of emails from comma-separated" do
    message = Message.new(emails: "alex@example.com  , damien@example.org  ")
    assert_equal ["alex@example.com", "damien@example.org"], message.emails
  end
end
