Rails.application.routes.draw do
  require 'resque_web'

  resources :teams do
    get :join
  end
  resources :runs

  resque_web_constraint = lambda do |request|
    current_user = request.env['warden'].user
    current_user.present? && current_user.respond_to?(:admin?) && current_user.admin?
  end

  constraints resque_web_constraint do
    mount ResqueWeb::Engine => "admin/resque_web"
  end

  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  root to: 'map#index'
  get 'about/about',  to: 'about#about'
  post 'about/send_message', to: 'about#send_message'
  get 'strava_auth',  to: 'strava_auth#strava_auth'
  get 'leader_data', to: 'leaderboard#data'
  get 'strava-webhook', to: 'strava_webhook#webhook'
end
