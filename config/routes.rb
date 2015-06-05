Rails.application.routes.draw do
  root to: 'application#welcome'
  get '/app', to: 'application#app'
  post '/new_order', to: 'orders#new_order'
  post '/change_order_state', to: 'orders#change_order_state'
  post '/new_comment', to: 'orders#new_comment'
  post '/get_orders', to: 'orders#get_orders'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
end
