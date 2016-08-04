require_relative '../db_config'

def createUser()
  user = User.new
  user.username = params[:username]
  user.imageurl = params[:imageurl]
  user.email = params[:email]
  user.password = params[:password]
  user.poochname = params[:poochname]
  user.poochbreed = params[:poochbreed]
  user.poochimageurl = params[:poochimageurl]
  user.save
  return user
end


def searchForUsers(searchTerm)
  users = User.where("poochbreed like :kw or username like :kw", :kw=>"%#{searchTerm}%")
  users = users.where.not(id: session[:user_id])
  return users
end




def searchForPosts()

# Client.where(created_at: (Time.now.midnight - 1.day)..Time.now.midnight)
# This will find all clients created yesterday by using a BETWEEN SQL statement:

end
