Rails.application.routes.draw do
  require 'resque_web'

  resque_web_constraint = lambda do |request|
    current_user = request.env['warden'].user
    current_user.present? #&& current_user.respond_to?(:admin?) && current_user.admin?
  end

  constraints resque_web_constraint do
    mount ResqueWeb::Engine => "admin/resque_web"
  end

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'map#index'
  get 'about/about', to: 'about#about'
end
