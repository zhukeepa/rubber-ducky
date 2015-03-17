Rails.application.routes.draw do
  root 'messages#new'
  get 'fail', to: 'messages#fail'

  resources :messages, only: [:create, :edit, :update] do 
    patch 'autosave', on: :member
  end
end
