require 'sinatra'
require 'sinatra/reloader'
require 'pg'
require 'pry'

require_relative 'db_config'

require_relative 'models/user'
require_relative 'models/friendship'

#data access
require_relative 'dataaccess/userdataaccess'


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


post '/signup' do
  createUser()
  redirect to '/'
end


post '/adduser/:user_id' do
  # connect to this user.
  binding.pry
  newComment = Comment.new
  binding.pry
  newComment.dish_id = params[:dish_id]
  newComment.commenttext =  params[:newCommentText]
  newComment.save
  redirect to '/'
end
