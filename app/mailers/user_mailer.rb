class UserMailer < ApplicationMailer
  def user_welcome_mail(user)
    @user = user
    mail(from: 'trees <nakau26@gmail.com>', to: @user.email, subject: 'ようこそtreesへ')
  end
end
