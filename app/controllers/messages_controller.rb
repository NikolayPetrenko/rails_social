class MessagesController < LoginController

  Pusher.app_id = '35482'
  Pusher.key = '4624f11f824b9e6718ef'
  Pusher.secret = 'c1a4a210fb191d157c95'

  def index
    @messages = Message.group('user_id').order('created_at DESC').find_all_by_receiver_id(current_user.id)
    @messages.each do |message|
      user = User.find message.user_id
      message[:avatar]    = { :url => user.avatar.url }
      message[:firstname] = user.firstname
      message[:lastname]  = user.lastname
    end
    respond_to do |format|
      format.html { render 'users/show'}
      format.json { render :json => @messages }
    end
  end

  def chat
    @messages = Message.where("(user_id = ? AND receiver_id = ?) OR (user_id = ? AND receiver_id = ?)", params[:id], current_user.id, current_user.id, params[:id]).order("created_at").find_all
    @messages.each do |message|
      user = User.find message.user_id
      message[:avatar] = { :thumb => { :url => user.avatar.thumb.url } }
      message[:firstname] = user.firstname
      message[:datetime]  = message.created_at.strftime("%d.%m.%Y at %I:%M:%S%p")
      message[:lastname]  = user.lastname
      message[:chat]      = User.find(params[:id])
    end
    respond_to do |format|
      format.html { render 'users/show'}
      format.json { render :json => @messages }
    end
  end

  def create
    message = current_user.messages.create(params[:message])
    message[:datetime]  = message.created_at.strftime("%d.%m.%Y at %I:%M:%S%p")
    Pusher["message_for_#{message.receiver_id}_#{message.user_id}"].trigger('new-message', { :user => message.user, :message => message })
    render :json => { :user => message.user, :message => message }
  end

  def destroy
    message = Message.find params[:id]
    Pusher["delete_message_for_#{message.receiver_id}_#{message.user_id}"].trigger('delete-message', { :message => message })
    message.destroy
    render :json => { :result => "ok" }
  end

end