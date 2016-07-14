module CommentsHelper
  def user_is_authorized_for_comment?(comment)
      current_user && (current_user == comment.user || current_user.admin?)
  end
  # def comments_for_topic(comment)
  #     raw comment.body, topic_comment_path(id: comment.id), class: 'panel-body'
  # end
end
