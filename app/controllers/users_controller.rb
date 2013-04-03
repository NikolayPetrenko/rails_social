class UsersController < LoginController

  def new
    if signed_in?
      redirect_to "/users/#{current_user.id}"
    else
      @title = "Sign up"
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      user = User.authenticate(params[:user][:email], params[:user][:password])
      sign_in user
      Friendship.create(:user_id => 1, :friend_id => user.id)
      redirect_to "/users/#{@user.id}"
    else
      # render :text => @user.errors.full_messages and return false
      flash[:alert] = @user.errors.full_messages
      redirect_to signup_path
    end
  end

	def show
    redirect_to root_path if current_user.nil?
    @user = User.find params[:id]
    if @user != current_user
      @current_friend = Friendship.where("(user_id = '#{@user.id}' AND friend_id = '#{current_user.id}') OR (user_id = '#{current_user.id}' AND friend_id = '#{@user.id}')").first
      if @current_friend.nil?
        @user[:status_friend] = "3"
      else
        @user[:status_friend] = @current_friend.accepted.nil? ? (@current_friend.user_id == current_user.id ? "2" : "0") : @current_friend.accepted
      end
    end
    respond_to do |format|
      format.html
      format.json { render :json => @user }
    end
  end

  def friends
    if params[:pending].nil?
      @users = Friendship
      .select('friendships.friend_id AS id, users.avatar, users.firstname, users.lastname')
      .joins('JOIN users ON friendships.friend_id = users.id')
      .where("friendships.accepted = 1 AND friendships.user_id = ?", params[:id])
    else
      @users = Friendship
      .select('friendships.user_id AS id, users.avatar, users.firstname, users.lastname')
      .joins('JOIN users ON friendships.user_id = users.id')
      .where("friendships.accepted IS NULL AND friendships.friend_id = ?", params[:id])
    end
    @users.each do |user_item|
      user = User.find user_item.id
      user_item.avatar = { :url => user.avatar.url }
    end
    render :json => @users
  end

  def actionFriend
    if params[:act] == "add"
      @user = User.find params[:id]
      @current_friend = Friendship.where("user_id = '#{@user.id}' AND friend_id = '#{current_user.id}'").first
      if !@current_friend.nil?
        Friendship.create(:friend_id => params[:id], :user_id => current_user.id, :accepted => 1)
        @current_friend.update_attributes(:accepted => 1)
      else
        Friendship.create(:user_id => current_user.id, :friend_id => params[:id])
      end
    else
      user_friend = Friendship.where("user_id = ?", current_user.id).find_by_friend_id params[:id]
      friend_user = Friendship.where("friend_id = ?", current_user.id).find_by_user_id params[:id]
      if !user_friend.nil?
        user_friend.delete
      end
      if !friend_user.nil?
        friend_user.delete
      end
    end
    render :json =>{ :result => "ok" }
  end

  def search
    query = "#{params[:search]}%"
    @users = User.where("id != ? AND (firstname like ? OR lastname like ? OR email like ?)", current_user.id, query, query, query).group
    respond_to do |format|
      format.html { render "show" }
      format.json { render :json => @users }
    end
  end

  def update
    @user = User.find current_user.id
    @message_bapass = 1
    if !params[:user].nil?
      if @user.update_attributes(params[:user])
        flash[:success] = "Profile success updated"
      else
        flash[:alert] = @user.errors.full_messages
      end
      #render :text => params[:user] and return false
      redirect_to '/edit'
    else
      render "edit"
    end
  end
end