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
  setup do 
    @one = messages(:one)
  end 

  test "time_limit should be converted to seconds" do 
    message = Message.new(time_limit: 1)
    assert_equal 60, message.time_limit
  end

  test "emails valid if it is comma-separated list of emails" do 
    assert_equal true, @one.valid? 
    @one.emails = "zhukeepa@gmail.com, alex.zhu.1994@gmail.com"
    assert_equal true, @one.valid? 
  end

  test "emails valid only if it is comma-separated list of emails" do 
    @one.emails = "zhukeepa@gmail.com, asdfg, alex.zhu.1994@gmail.com"
    assert_equal false, @one.valid? 
  end
end
