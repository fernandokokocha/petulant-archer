require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @valid_params = {:user => users(:one),
                     :order => orders(:one),
                     :content => 'Content'}
  end

  test 'comment requires content' do
    params = @valid_params.without(:content)
    o = Comment.new(params)
    assert_not o.valid?
  end

  test 'comment requires user' do
    params = @valid_params.without(:user)
    o = Comment.new(params)
    assert_not o.valid?
  end

  test 'comment requires order' do
    params = @valid_params.without(:order)
    o = Comment.new(params)
    assert_not o.valid?
  end

  test 'comment can be valid' do
    o = Comment.new(@valid_params)
    assert o.valid?
  end
end