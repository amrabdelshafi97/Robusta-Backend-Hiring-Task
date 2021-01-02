class UserMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]
    @url = 'http://localhost:3000/'
    mail(from: "amrayoub97@gmail.com", to: @user.email, subject: 'Welcome to My Robusta Hiring Movie App')
  end
end
