class Order < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  validates :content, :user, presence: true
  POSSIBLE_STATES = %w(active finalized ordered delivered)
  validates :state, :inclusion => {:in => POSSIBLE_STATES}

  scope :sorted, -> { order('updated_at DESC') }
  scope :active, -> { sorted.where(state: 'active') }
  scope :finalized, -> { sorted.where.not(state: 'active') }
end
