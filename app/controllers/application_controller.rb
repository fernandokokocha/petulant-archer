class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def welcome
    if current_user
      redirect_to app_path
    end
  end

  def app
    authenticate_user!
    @active_orders = Order.active.map{ |order| order.hash_form(current_user)  }
    @finalized_orders = Order.finalized.map{ |order| order.hash_form(current_user)  }
  end
end
