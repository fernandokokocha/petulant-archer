class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :order
  validates :content, :user, :order, presence: true
end
