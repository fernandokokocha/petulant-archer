class WelcomeController < ApplicationController
  def index
    if current_user
      redirect_to app_path
    end
  end

  def app
    authenticate_user!
    @active_orders = Order.active.decorate
    @finalized_orders = Order.finalized.decorate
  end
end