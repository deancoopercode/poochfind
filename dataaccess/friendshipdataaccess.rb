require_relative '../db_config'

def createFriendship(userId)

  newFriendship = Friendship.new
  newFriendship.user_id = session[:user_id]
  newFriendship.friend_id =  params[:user_id]
  newFriendship.save

  # also create the reverse relationship
  reverseFriendship = Friendship.new
  reverseFriendship.user_id = params[:user_id]
  reverseFriendship.friend_id =  session[:user_id]
  reverseFriendship.save
  
end
