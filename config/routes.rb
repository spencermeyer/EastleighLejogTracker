Rails.application.routes.draw do
  resources :runs
  require 'resque_web'

  resque_web_constraint = lambda do |request|
    current_user = request.env['warden'].user
    current_user.present? #&& current_user.respond_to?(:admin?) && current_user.admin?
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
  get 'strava_auth',  to: 'strava_auth#strava_auth'
  get 'leader_data', to: 'leaderboard#data'
end
