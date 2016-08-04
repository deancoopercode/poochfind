class User < ActiveRecord::Base
  validates_presence_of :email, :password
  has_many :friendships, :foreign_key => "user_id",
       :class_name => "Friendship"

  has_many :friends, :through => :friendships
  has_many :posts

  has_secure_password
end
