class OrdersController < ApplicationController
  before_action :authenticate_user!

  def new_order
    order = Order.new(:content => params[:content],
                      :state => 'active',
                      :user => current_user)
                 .decorate
    if order.valid?
      order.save!
      render json: order.hash_form(current_user)
    else
      render json: { :errors => order.errors.full_messages }, :status => 400
    end
  end

  def change_order_state
    order = Order.find(params[:id]).decorate
    order.state = params[:state]
    if order.valid?
      order.save!
      render json: order.hash_form(current_user)
    else
      head(:bad_request)
    end
  end

  def new_comment
    comment = Comment.new(:content => params[:content],
                          :user => current_user,
                          :order => Order.find(params[:id]))
    if comment.valid?
      comment.save!
      render json: comment.order.decorate.hash_form(current_user)
    else
      render json: { :errors => comment.errors.full_messages }, :status => 400
    end
  end

  def get_orders
    active_orders = Order.active.decorate.map{ |order| order.hash_form(current_user)  }
    finalized_orders = Order.finalized.decorate.map{ |order| order.hash_form(current_user)  }
    render :json => { :activeOrders => active_orders, :finalizedOrders => finalized_orders }
  end
end
