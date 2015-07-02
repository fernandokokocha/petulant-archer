class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:update, :destroy]

  def index
    active_orders = Order.active.decorate.map{ |order| order.hash_form(current_user)  }
    finalized_orders = Order.finalized.decorate.map{ |order| order.hash_form(current_user)  }
    render :json => { :activeOrders => active_orders, :finalizedOrders => finalized_orders }
  end

  def show
    render nothing: true
  end

  def new
    render nothing: true
  end

  def edit
    render nothing: true
  end

  def create
    @order = Order.new(order_params).decorate
    @order.user = current_user
    if @order.save
      render json: @order.hash_form(current_user)
    else
      render json: { :errors => @order.errors.full_messages }, :status => 400
    end
  end

  def update
    if @order.update(order_params)
      render json: @order.hash_form(current_user)
    else
      head(:bad_request)
    end
  end

  def destroy
    @order.destroy
    render nothing: true
  end

  private
  def set_order
    @order = Order.find(params[:id]).decorate
  end

  def order_params
    params.require(:order).permit(:content, :state)
  end
end
