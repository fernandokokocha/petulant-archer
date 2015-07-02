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
    @active_orders = Order.active.map{ |order| hash_from_order(order, current_user)  }
    @finalized_orders = Order.finalized.map{ |order| hash_from_order(order, current_user)  }
  end
end
