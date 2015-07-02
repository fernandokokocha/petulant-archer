class Order < ActiveRecord::Base
  POSSIBLE_STATES = %w(active finalized ordered delivered)

  belongs_to :user
  has_many :comments
  validates :content, :user, presence: true
  validates :state, :inclusion => {:in => POSSIBLE_STATES}

  scope :sorted, -> { order('updated_at DESC') }
  scope :active, -> { sorted.where(state: 'active') }
  scope :finalized, -> { sorted.where.not(state: 'active') }
end
