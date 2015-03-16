Rails.application.routes.draw do
  root 'messages#new'
  post '/', to: 'messages#write'
  post 'messages/send_message'
  post 'autosave', to: 'messages#autosave'
  get 'fail', to: 'messages#fail'
end
