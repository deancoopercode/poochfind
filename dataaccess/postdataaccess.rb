require_relative '../db_config'

def createPost()
  post = Post.new

  post.user_id = session[:user_id]
  post.primaryimageurl = params[:primaryimageurl]
  post.secondaryimageurl = params[:secondaryimageurl]
  post.content = params[:content]
  post.datetimeofpost = Time.now
  post.save

end

#
# select * from posts where user_id in
# (select friend_id from friendships where user_id)
#

#INNER JOIN


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
