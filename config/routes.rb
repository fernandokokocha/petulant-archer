Rails.application.routes.draw do
  root to: 'welcome#index'
  get '/app', to: 'welcome#app'

  resources :orders
  resources :comments

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
end
