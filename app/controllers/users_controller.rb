class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render json: User.all
  end

  def show
    render json: User.find(params[:id])
  end

  def create
    user = User.create(user_params)
    render json: user
  end

  def destroy
    User.find(params[:id]).destroy!
    render json: {}, status: 204
  end

  private

  def user_params
    params.permit(:username, :email, :password)
  end
end
