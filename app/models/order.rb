class Order < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  validates :content, :user, presence: true
  possible_states = %w(active finalized ordered delivered)
  validates :state, :inclusion => {:in => possible_states}
end
