Rails.application.routes.draw do
  root 'messages#index'
  get 'fail', to: 'messages#fail'
  get "/auth/:provider/callback" => 'sessions#create'

  resources :messages, only: [:new, :create, :update] do 
    patch 'send_message', on: :member
    get 'compose', on: :collection
  end
end
