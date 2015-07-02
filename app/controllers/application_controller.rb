class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ApplicationHelper

  def welcome
    if current_user
      redirect_to app_path
    end
  end

  def app
    authenticate_user!
    orders = Order.all.order('updated_at DESC')
    @active_orders = orders.where(state: 'active').map{ |order| hash_from_order(order, current_user)  }
    @finalized_orders = orders.where.not(state: 'active').map{ |order| hash_from_order(order, current_user)  }
  end
end
