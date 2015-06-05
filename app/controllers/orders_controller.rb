class OrdersController < ApplicationController
  include ApplicationHelper

  def new_order
    o = Order.new(:content => params[:content],
                  :state => 'active',
                  :user => current_user)
    if o.valid?
      o.save!
      render json: hash_from_order(o, current_user)
    else
      render json: { :errors => o.errors.full_messages }, :status => 400
    end
  end

  def change_order_state
    o = Order.find(params[:id])
    o.state = params[:state]
    if o.valid?
      o.save!
      render json: hash_from_order(o, current_user)
    else
      head(:bad_request)
    end
  end

  def new_comment
    c = Comment.new(:content => params[:content],
                    :user => current_user,
                    :order => Order.find(params[:id]))
    if c.valid?
      c.save!
      render json: hash_from_order(c.order, current_user)
    else
      render json: { :errors => c.errors.full_messages }, :status => 400
    end
  end

  def get_orders
    orders = Order.all.order('updated_at DESC')
    @active_orders = orders.where(state: 'active').map{ |o| hash_from_order(o, current_user)  }
    @finalized_orders = orders.where.not(state: 'active').map{ |o| hash_from_order(o, current_user)  }
    render :json => { :activeOrders => @active_orders, :finalizedOrders => @finalized_orders }
  end
end
