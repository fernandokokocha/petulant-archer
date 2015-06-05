module ApplicationHelper
  def hash_from_order(order)
    day_format = '%y-%m-%d'
    time_format = '%H:%M'

    {:content => order.content,
     :day => order.updated_at.strftime(day_format),
     :time => order.updated_at.strftime(time_format),
     :created_at => order.created_at.strftime(time_format),
     :user_image => order.user.image,
     :id => order.id,
     :state => order.state,
     :comments => order.comments.map { |c| { :user_image => c.user.image,
                                             :content => c.content,
                                             :time => c.created_at.strftime(time_format) } },
     :can_comment => order.comments.where(user: current_user).empty?
    }
  end
end
