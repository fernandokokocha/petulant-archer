class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :order
  validates :content, presence: true
end
