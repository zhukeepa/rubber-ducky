class SessionsController < ApplicationController
  layout false
 
  def new
  end
 
  def create
    @auth = request.env['omniauth.auth']['credentials']
    Token.create(
      access_token: @auth['token'],
      refresh_token: @auth['refresh_token'],
      expires_at: Time.at(@auth['expires_at']).to_datetime)

    redirect_to new_message_url
  end
end