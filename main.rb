require 'sinatra'
require 'pg'
require 'pry'

require_relative 'db_config'

require_relative 'models/user'
require_relative 'models/friendship'
require_relative 'models/post'
require_relative 'models/comment'

#data access
require_relative 'dataaccess/userdataaccess'
require_relative 'dataaccess/postdataaccess'
require_relative 'dataaccess/friendshipdataaccess'
require_relative 'dataaccess/commentdataaccess'

enable :sessions

helpers do
  def cleanYoutubeString(string)
    if string.include? 'watch'
      return string.sub('www.youtube.com/watch?v=', "www.youtube.com/embed/")
    end
    if !string.include? 'embed'
      return string.sub('www.youtube.com/', "www.youtube.com/embed/")
    end
    return string
  end

  def logged_in?
    if User.find_by(id: session[:user_id])
      return true
    else
      return false
    end
  end
  def current_user
    return User.find_by(id: session[:user_id])
  end
end

get '/' do
  if logged_in?
    @userPostFeed = loadPosts()
  end
  erb :index
end

get '/session/new' do
  erb :login
end

post '/session' do
  user = User.find_by(email: params[:email])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
  end
  redirect to '/'
end

delete '/session' do
  session[:user_id] = nil
  redirect to '/'
end

get '/signup' do
  erb :signup
end

get '/searchusers' do
  if !logged_in?
    redirect to '/'
  end
  erb :searchusers
end

post '/searchusers' do
  @userSearchResults = searchForUsers(params[:searchuserkeywords])
  erb :searchusersresult
end

get '/post' do
  if !logged_in?
    redirect to '/'
  end
  erb :post
end

post '/post' do
  createPost()
  redirect to '/'
end

delete '/post/:id' do
  postToDelete = Post.find(params[:id])
  postToDelete.destroy
  redirect to '/'
end

#getting a form page, not posting anything
get '/post/:id/edit' do
  @post = Post.find(params[:id])
  erb :edit
end

put '/post/:id' do
  updatePost(params[:id], params[:content], params[:primaryimageurl])
 redirect '/'
end

post '/signup' do
  createUser()
  redirect to '/'
end

post '/adduser/:user_id' do
  createFriendship(params[:user_id])
  redirect to '/'
end

get '/friendlist' do
  if !logged_in?
    redirect to '/'
  end

  @friendList = current_user.friends
  erb :friendlist
end

post '/comment/:post_id' do
  createComment(params[:post_id], params[:newCommentText])
  redirect to '/'
end

delete '/comment/:comment_id' do
  commentToDelete = Comment.find(params[:comment_id])
  commentToDelete.destroy
  redirect to '/'
end
