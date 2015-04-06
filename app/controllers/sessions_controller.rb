class SessionsController < ApplicationController
  def create
    @auth = request.env['omniauth.auth']['credentials']

    session[:token_id] = Token.create!(
      access_token: @auth['token'],
      refresh_token: @auth['refresh_token'],
      expires_at: Time.at(@auth['expires_at']).to_datetime).id

    redirect_to new_message_url
  end
end