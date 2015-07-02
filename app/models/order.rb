class Order < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  validates :content, :user, presence: true
  POSSIBLE_STATES = %w(active finalized ordered delivered)
  validates :state, :inclusion => {:in => POSSIBLE_STATES}
end
