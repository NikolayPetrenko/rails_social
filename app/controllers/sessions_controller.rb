# coding: utf-8
class SessionsController < LoginController
  def new
    if signed_in?
      redirect_to "/users/#{current_user.id}"
    else
      @title = "Login"
    end
  end

  def create
  	user = User.authenticate(params[:session][:email], params[:session][:password])
  	if user.nil?
  		flash.now[:alert] = "Wrong combination login/password."
  		@title = "Login"
  		render "new"
  	else
  		sign_in user
  		redirect_to "/users/#{user.id}"
  	end
  end

  def forgot_password
    @title = "Forgot Password"
    if params[:forgot]
      user = User.find_by_email(params[:forgot][:email]);
      if user.nil?
        flash.now[:alert] = "Email does not exist in the system."
        render "forgot_password"
      else
        user.hashlink = Digest::SHA2.hexdigest("#{Time.now.utc}--#{params[:forgot][:email]}");
        user.hashtime = Time.now.utc+1.day;
        user.save();
        UserMailer.forgotpassword_email(user).deliver
        flash[:success] = "On the email was sent a link to change your password."
        redirect_to root_path
      end
    end
  end

  def new_password
    @title = "New password"
    user = User.where("hashlink = '#{params[:hashlink]}' AND hashtime > '#{Time.now.utc}'").first
    if user.nil?
      flash[:alert] = "Error. Invalid link to reset your password."
      redirect_to root_path
    else
      @hash = params[:hashlink]
    end
  end

  def change_password
    user = User.find_by_hashlink(params[:new][:hashlink])
    params[:new][:hashlink] = ''
    user.update_attributes(params[:new])
    flash[:success] = "Password successfully changed."
    redirect_to root_path
  end

  def destroy
  	sign_out
  	redirect_to root_path
  end
end