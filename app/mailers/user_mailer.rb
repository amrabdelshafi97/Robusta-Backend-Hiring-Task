class UserMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]
    @url = ENV["DOMAIN"] + '/login'
    mail(from: "amrayoub97@gmail.com", to: @user.email, subject: 'Welcome to Robusta Hiring Movie App')
  end
end
