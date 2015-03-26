require 'test_helper'

class MessagesTest < ActionDispatch::IntegrationTest
  setup do 
    @token = tokens(:one)
    
  end 

  test "message submits properly" do
    visit new_message_url

    puts html
    if first(:Email) == nil
      puts "GRAGH"
      raise 
    end 

    fill_in :Email,  with: 'alexthrowaway123zz'
    fill_in :Passwd, with: 'alexthrowaway123zzalexthrowaway123zz'

    click_button 'Sign in'

    until current_path == '/'
      sleep(1.seconds)
      puts current_path
    end

    assert current_path == '/'
  end
end
