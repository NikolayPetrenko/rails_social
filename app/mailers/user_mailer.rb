class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def forgotpassword_email(user)
    @user = user
    @url = "#{root_url(:only_path => false)}newpassword/#{user.hashlink}"
    mail(:to => user.email, :subject => "Forgot password")
  end

end