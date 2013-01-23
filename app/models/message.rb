class Message < ActiveRecord::Base
  attr_accessible :receiver_id, :text, :user_id
  belongs_to :user
end
