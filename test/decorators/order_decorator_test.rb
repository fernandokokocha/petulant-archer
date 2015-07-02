require 'test_helper'

class OrderDecoratorTest < Draper::TestCase
  def setup
    @user1 = User.create!(:email => 'user5@example.com',
                          :image => 'www.example.com/5')
    @user2 = User.create!(:email => 'user6@example.com',
                          :image => 'www.example.com/6')
    @order = Order.create!(:content => 'Order',
                           :user => @user1,
                           :state => 'active')
    @comment1 = Comment.create!(:content => 'Comment 1',
                                :order => @order,
                                :user => @user1)
    @comment2 = Comment.create!(:content => 'Comment 2',
                                :order => @order,
                                :user => @user2)
    @hash = @order.decorate.hash_form(@user1)
  end

  test 'hash has proper content key' do
    assert_equal @order.content, @hash[:content]
  end

  test 'hash has proper user_image key' do
    assert_equal @user1.image, @hash[:user_image]
  end

  test 'hash has proper id key' do
    assert_equal @order.id, @hash[:id]
  end

  test 'hash has proper state key' do
    assert_equal @order.state, @hash[:state]
  end

  test 'hash has proper can_comment key' do
    assert_equal false, @hash[:can_comment]
  end

  test 'hash has proper comments key' do
    assert_equal 2, @hash[:comments].length
    assert_equal @comment1.content, @hash[:comments][0][:content]
    assert_equal @user1.image, @hash[:comments][0][:user_image]
    assert_equal @comment2.content, @hash[:comments][1][:content]
    assert_equal @user2.image, @hash[:comments][1][:user_image]
  end

  test 'user who didnt comment can comment' do
    user3 = User.create!(:email => 'user7@example.com',
                         :image => 'www.example.com/7')
    hash = @order.decorate.hash_form(user3)
    assert_equal true, hash[:can_comment]
  end
end
