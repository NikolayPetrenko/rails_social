class Friendship < ActiveRecord::Base

  attr_accessible :accepted, :friend_id, :user_id

  belongs_to :user

end
