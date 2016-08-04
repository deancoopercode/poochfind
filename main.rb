require 'sinatra'
require 'sinatra/reloader'
require 'pg'
require 'pry'

require_relative 'db_config'

require_relative 'models/user'
require_relative 'models/friendship'
require_relative 'models/post'

#data access
require_relative 'dataaccess/userdataaccess'
require_relative 'dataaccess/postdataaccess'
require_relative 'dataaccess/friendshipdataaccess'

enable :sessions

helpers do
  def cleanYoutubeString(string)
    if !string.include? 'embed'
      return string.sub('http://www.youtube.com/', "http://www.youtube.com/embed/")
    end
    if string.include? 'watch'
      return string.sub('http://www.youtube.com/watch?v=', "http://www.youtube.com/embed/")
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
  # load posts here and show them on the homepage.
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
    redirect to '/'
  else
    erb :login
  end
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
 post = Post.find(params[:id])
 post.content = params[:content]
 post.primaryimageurl= params[:primaryimageurl]
 post.save
 redirect '/'
end


post '/signup' do
  createUser()
  redirect to '/'
end

post '/adduser/:user_id' do
  # connect to this user.
  newFriendship = Friendship.new

  newFriendship.user_id = current_user.id
  newFriendship.friend_id =  params[:user_id]
  newFriendship.save
  redirect to '/'
end

get '/friendlist' do
  if !logged_in?
    redirect to '/'
  end

  @friendList = current_user.friends
  erb :friendlist
end
