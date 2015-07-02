require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  def setup
    @valid_params = {:user => users(:one),
                     :content => 'Content',
                     :state => 'active'}
  end

  test 'order requires content' do
    params = @valid_params.without(:content)
    order = Order.new(params)
    assert_not order.valid?
  end

  test 'order requires non-empty content' do
    params = @valid_params
    params[:content] = ''
    order = Order.new(params)
    assert_not order.valid?
  end

  test 'order requires user' do
    params = @valid_params.without(:user)
    order = Order.new(params)
    assert_not order.valid?
  end

  test 'order requires state' do
    params = @valid_params.without(:state)
    order = Order.new(params)
    assert_not order.valid?
  end

  test 'order requires one of valid states' do
    params = @valid_params
    params[:state] = 'Invalid state'
    order = Order.new(params)
    assert_not order.valid?
  end

  test 'order can be valid' do
    order = Order.new(@valid_params)
    assert order.valid?
  end

  test 'order has active state after save' do
    order = Order.create(@valid_params)
    assert 'active', order.state
  end
end