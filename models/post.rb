class Post < ActiveRecord::Base
    validates_presence_of :user_id, :content
    belongs_to :user
    has_many :comments, :dependent => :delete_all

end
