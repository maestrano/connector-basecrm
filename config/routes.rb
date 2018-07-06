Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  mount Maestrano::Connector::Rails::Engine, at: '/'

  root 'home#index'
  get 'home/index' => 'home#index'
  get 'home/redirect_to_external' => 'home#redirect_to_external'
  put 'home/update' => 'home#update'
  post 'home/synchronize' => 'home#synchronize'

  match 'auth/:provider/request', to: 'oauth#request_omniauth', via: [:get, :post]
  match 'auth/:provider/callback', to: 'oauth#create_omniauth', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout_omniauth', to: 'oauth#destroy_omniauth', as: 'signout_omniauth', via: [:get, :post]

  get 'synchronizations/index' => 'synchronizations#index'
  get 'shared_entities/index' => 'shared_entities#index'

  # Sidekiq Admin
  require 'sidekiq/web'
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    ENV['SIDEKIQ_USERNAME'].present? &
    ActiveSupport::SecurityUtils.secure_compare(username, ENV['SIDEKIQ_USERNAME']) &
    ActiveSupport::SecurityUtils.secure_compare(password, ENV['SIDEKIQ_PASSWORD'])
  end
  mount Sidekiq::Web => '/sidekiq'
end
