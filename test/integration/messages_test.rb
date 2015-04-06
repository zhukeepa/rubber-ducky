require 'test_helper'

def fill_in_ckeditor(locator, opts)
  content = opts.fetch(:with).to_json
  page.execute_script <<-SCRIPT
    CKEDITOR.instances['#{locator}'].setData(#{content});
    $('textarea##{locator}').text(#{content});
  SCRIPT
end

class MessagesTest < ActionDispatch::IntegrationTest
  setup do 
    @token = tokens(:one)
    @one = messages(:one)
  end 

  test "properly sends email to zhukeepa@gmail.com via send" do
    visit new_message_path

    fill_in :message_title, with: @one.title
    fill_in :message_time_limit, with: @one.time_limit
    fill_in :message_emails, with: @one.emails

    click_button 'Start writing!'

    assert_equal current_path, compose_messages_path

    fill_in_ckeditor :message_body, with: @one.body

    click_button 'Send!'
  end
end
