Rails.application.routes.draw do
  root 'messages#new'
  post '/', to: 'messages#write'
  post 'messages/send_message'
end
