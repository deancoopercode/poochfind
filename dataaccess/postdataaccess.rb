require_relative '../db_config'

def createPost()
  post = Post.new

  post.user_id = session[:user_id]
  post.primaryimageurl = params[:primaryimageurl]
  post.content = params[:content]
  post.save

end

def updatePost(postId, content, image)
  post = Post.find(postId)
  post.content = content
  post.primaryimageurl = image
  post.save
end


def loadPosts()

  #change this to use two inner joins perhaps
  # all friends posts
  posts = Post.joins("INNER JOIN friendships ON friendships.friend_id = posts.user_id").where("friendships.user_id = " + session[:user_id].to_s)

  # all users posts
  userPosts = Post.where(user_id: session[:user_id])
  finalPosts = posts + userPosts
  finalPosts = finalPosts.sort_by{ |p| [p.created_at] }

  # binding.pry
  return finalPosts
end
