class SessionsController < ApplicationController
  layout false
 
  def new
  end
 
  def create
    @auth = request.env['omniauth.auth']['credentials']
    session[:access_token] = @auth['token']

    redirect_to new_message_url
  end
end