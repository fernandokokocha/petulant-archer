class OrderDecorator < Draper::Decorator
  delegate_all

  DAY_FORMAT = '%y-%m-%d'
  TIME_FORMAT = '%H:%M'

  def hash_form(current_user)
    {:content => content,
     :day => updated_at.strftime(DAY_FORMAT),
     :time => updated_at.strftime(TIME_FORMAT),
     :created_at => created_at.strftime(TIME_FORMAT),
     :user_image => user.image,
     :id => id,
     :state => state,
     :comments => comments.map { |comment| { :user_image => comment.user.image,
                                             :content => comment.content,
                                             :time => comment.created_at.strftime(TIME_FORMAT) } },
     :can_comment => comments.where(user: current_user).empty?
    }
  end
end
