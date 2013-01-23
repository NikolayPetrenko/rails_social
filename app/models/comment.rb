class Comment < ActiveRecord::Base
  attr_accessible :pid, :side_id, :text, :user_id

  belongs_to :user

  def self.find_comments_by_side_id(side_id)
    select('users.id AS user_id, users.avatar, users.firstname, users.lastname, comments.text, comments.side_id, comments.id AS id')
    .joins(:user)
    .where('side_id = ?', side_id)
    .order('comments.created_at ASC')
  end

end
