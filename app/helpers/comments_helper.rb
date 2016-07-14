module CommentsHelper
  def user_is_authorized_for_comment?(comment)
      current_user && (current_user == comment.user || current_user.admin?)
  end
  # def comment_box(comment,pl)
  #     raw labels.map { |l| link_to l.name, label_path(id: l.id), class: 'btn-xs btn-primary' }.join(' ')
  # end
end
