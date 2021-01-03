class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
      session[:user_id] = @user.id
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to '/signup'
    end
  end

  def failure
    session[:user_id] = nil
    redirect_to root_path
  end
end