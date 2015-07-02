require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @valid_params = {:user => users(:one),
                     :order => orders(:one),
                     :content => 'Content'}
  end

  test 'comment requires content' do
    params = @valid_params.without(:content)
    order = Comment.new(params)
    assert_not order.valid?
  end

  test 'comment requires user' do
    params = @valid_params.without(:user)
    order = Comment.new(params)
    assert_not order.valid?
  end

  test 'comment requires order' do
    params = @valid_params.without(:order)
    order = Comment.new(params)
    assert_not order.valid?
  end

  test 'comment can be valid' do
    order = Comment.new(@valid_params)
    assert order.valid?
  end
end