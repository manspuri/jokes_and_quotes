module PostHelper
  def nested_comments(comments)
    top_level = comments
    sub_comments = []
    collect = []
    
    comments.each do |comment|
      shared_commentables = Comment.where(commentable_id: comment.commentable_id, commentable_type: comment.commentable_type)
      collect << comment
      if comment.has_comments?
        sub_comments += comment.comments
      else
        sub_comments += shared_commentables
      end
    end

    if sub_comments.last == top_level.last || ((sub_comments.last.commentable_id == top_level.last.id) && (sub_comments.last.commentable_type == "Post"))
      return collect.uniq
    end
    nested_comments(sub_comments)
  end
end

