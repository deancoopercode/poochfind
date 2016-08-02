require_relative '../db_config'

def createPost()
  post = Post.new

  post.user_id = current_user.id

  post.primaryimageurl = params[:primaryimageurl]
  post.secondaryimageurl = params[:secondaryimageurl]
  post.comments = params[:comments]

  post.save

end


def loadPosts()
  binding.pry
  return Post.all
end
