require 'test_helper'


class MessagesTest < ActionDispatch::IntegrationTest
  setup do 
    @one = messages(:one)
  end 

  test "the truth" do
    visit '/'

    within '#new_message' do 
      fill_in :message_title, with: @one.title
      fill_in :message_time_limit, with: @one.time_limit
      fill_in :message_emails, with: @one.emails

      click_button 'Start writing!'
    end

    assert has_content?(@one.title), html

  end
end
