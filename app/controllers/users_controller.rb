class UsersController < ApplicationController
  # GET /user - Get All Users List
  def index
    render json: User.all
  end

  # GET /user/:id - Get User By ID From Users List
  def show
    render json: User.find(params[:id])
  end

  # POST /user - Add A New User To Users List
  def create
    user = User.create(user_params)
    render json: user
  end

  # PUT/PATCH /user/:id - Update A User By ID From Users List
  def update
    begin
      @user = User.update(user_params)
    rescue
      return render status: 500
    end
    render json: @user, status: 202
  end

  # Delete /user/:id - Delete User By ID From Users List
  def destroy
    User.find(params[:id]).destroy!
    render json: {}, status: 204
  end

  # DELETE /user/login - Authenticate User
  def userLogin
    #TODO Authenticate User
  end

  #GET /user/:id/watchlist - Get User Movies Watchlist
  def getUserMovieWatchList
    render json: Watchlist.find(user_id: params[:id])
  end

  private

  def user_params
    params.permit(:username, :email, :password)
  end
end
