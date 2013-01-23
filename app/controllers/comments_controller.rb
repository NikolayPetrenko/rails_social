class CommentsController < LoginController

  Pusher.app_id = '35482'
  Pusher.key = '4624f11f824b9e6718ef'
  Pusher.secret = 'c1a4a210fb191d157c95'

  def index
    @comments = Comment.find_comments_by_side_id(params[:id])
    @comments.each do |comment|
      user = User.find comment.user_id
      comment.avatar = { :url => user.avatar.url }
    end
    render :json => @comments
  end

  def create
    @comment = current_user.comments.create(params[:comment])
    Pusher["comment_for_#{@comment.side_id}"].trigger('new-comment', { :comment => @comment, :user => @comment.user })
    render :json => { :user => @comment.user, :comment => @comment }
  end

  def destroy
    @comment = Comment.find params[:id]
    Pusher["delete_comment_from_#{@comment.side_id}"].trigger('delete-comment', { :comment => @comment, :user => current_user })
    @comment.destroy
    render :json => { :result => "ok" }
  end

end