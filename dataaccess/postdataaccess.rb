require_relative '../db_config'

def createPost()
  post = Post.new

  post.user_id = session[:user_id]

  post.primaryimageurl = params[:primaryimageurl]
  post.secondaryimageurl = params[:secondaryimageurl]
  post.content = params[:content]

  post.save

end


def loadPosts()
  return Post.all
end
