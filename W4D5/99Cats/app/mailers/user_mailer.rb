class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user 
    @url = 'http://example.com/session/new' #not sure how this is fetching the different emails
    mail(to: user.username, subject: 'Welcome to 99 Cats')
end
