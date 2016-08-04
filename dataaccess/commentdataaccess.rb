require_relative '../db_config'

def createComment(postId, newCommentText)
  newComment = Comment.new
  newComment.post_id = postId
  newComment.user_id = session[:user_id]
  newComment.content =  newCommentText
  newComment.save
end
