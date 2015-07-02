class CommentsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    render nothing: true
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
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.order = Order.find(params[:order_id])
    if @comment.save
      render json: @comment.order.decorate.hash_form(current_user)
    else
      render json: { :errors => @comment.errors.full_messages }, :status => 400
    end
  end

  def update
    render nothing: true
  end

  def destroy
    render nothing: true
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end