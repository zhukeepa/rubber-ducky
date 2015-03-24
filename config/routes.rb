Rails.application.routes.draw do
  root 'messages#index'#/auth/google_oauth2' => 'sessions#create'
  get 'fail', to: 'messages#fail'
  get "/auth/:provider/callback" => 'sessions#create'

  resources :messages, only: [:new, :create, :update] do 
    patch 'autosave', on: :member
    get 'compose', on: :collection
  end
end
