require 'sinatra'
require 'sinatra/reloader'
require 'pg'
require 'pry'

require_relative 'db_config'

require_relative 'models/user'
require_relative 'models/friendship'

#data access
require_relative 'dataaccess/userdataaccess'
require_relative 'dataaccess/postdataaccess'
require_relative 'dataaccess/friendshipdataaccess'

enable :sessions

helpers do
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
  @userPostFeed = loadPosts()
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

get '/signup/new' do
  erb :signup
end

get '/searchusers' do
  erb :searchusers
end

post '/searchusers' do
  @userSearchResults = searchForUsers(params[:searchuserkeywords])

  erb :searchusersresult
end



get '/post' do
  erb :post
end


post '/post' do
  createPost()
  redirect to '/'
end




post '/signup' do
  createUser()
  redirect to '/'
end


post '/adduser/:user_id' do
  # connect to this user.
  binding.pry
  newFriendship = Friendship.new

  newFriendship.user_id = current_user.id
  newFriendship.friend_id =  params[:user_id]
  newFriendship.save
  redirect to '/'
end



get '/friendlist' do
  binding.pry
  @friendList = current_user.friends
  erb :friendlist
end
