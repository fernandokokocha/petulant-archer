module ApplicationHelper
  def hash_from_order(order, current_user)
    day_format = '%y-%m-%d'
    time_format = '%H:%M'

    {:content => order.content,
     :day => order.updated_at.strftime(day_format),
     :time => order.updated_at.strftime(time_format),
     :created_at => order.created_at.strftime(time_format),
     :user_image => order.user.image,
     :id => order.id,
     :state => order.state,
     :comments => order.comments.map { |comment| { :user_image => comment.user.image,
                                                   :content => comment.content,
                                                   :time => comment.created_at.strftime(time_format) } },
     :can_comment => order.comments.where(user: current_user).empty?
    }
  end
end
