require_relative '../db_config'

def createFriendship(userId)

  # search to see that we dont already have this Friendship
  currentFriend = Friendship.find_by user_id: session[:user_id], friend_id: params[:user_id]

  if currentFriend == nil
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
end
