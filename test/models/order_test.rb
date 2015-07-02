require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  def setup
    @valid_params = {:user => users(:one),
                     :content => 'Content',
                     :state => 'active'}
  end

  test 'order requires content' do
    params = @valid_params.without(:content)
    o = Order.new(params)
    assert_not o.valid?
  end

  test 'order requires non-empty content' do
    params = @valid_params
    params[:content] = ''
    o = Order.new(params)
    assert_not o.valid?
  end

  test 'order requires user' do
    params = @valid_params.without(:user)
    o = Order.new(params)
    assert_not o.valid?
  end

  test 'order requires state' do
    params = @valid_params.without(:state)
    o = Order.new(params)
    assert_not o.valid?
  end

  test 'order requires one of valid states' do
    params = @valid_params
    params[:state] = 'Invalid state'
    o = Order.new(params)
    assert_not o.valid?
  end

  test 'order can be valid' do
    o = Order.new(@valid_params)
    assert o.valid?
  end

  test 'order has active state after save' do
    o = Order.create(@valid_params)
    assert 'active', o.state
  end
end