class UsersController < ApplicationController
  def new
    @user = User.new
  end

  # GET /user - Get All Users List
  # GET /user - Get All Users List
  def index
    begin
      users = User.all
    rescue Exception => exc
      return render json: { error => exc.message }, status: 500
    end
    render json: users, status: 200
  end

  # GET /user/:id - Get User By ID From Users List
  def show
    begin
      user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      return render json: { "error": "User not found, Please enter valid user id" }, status: 400
    rescue Exception => exc
      return render json: { "error": exc.message }, status: 500
    end
    render json: user, status: 200
  end

  # POST /user - Add A New User To Users List
  def create
    begin
      #@user.errors.clear

      @user = User.new(user_params)
      if @user.save
        flash[:success] = "Please check your email to activate your account."
        UserMailer.with(user: user).welcome_email.deliver_later
        session[:user_id] = @user.id
        redirect_to '/'
      end
      if @user.errors.any?
        render 'new'
      end
    rescue Exception => exc
      return render json: { "error" => exc.message }, status: 500
    end
    #render json: @user, status: 200
  end

  # PUT/PATCH /user/:id - Update An User By ID From Users List
  def update
    begin
      User.find(params[:id])
      user = User.update(user_params)
      if user.errors.size > 0
        return render json: user.errors, status: 400
      end
    rescue ActiveRecord::RecordNotFound
      return render json: { "error": "User not found, Please enter valid user id" }, status: 400
    rescue Exception => exc
      return render json: { "error" => exc.message }, status: 500
    end
    render json: user, status: 200
  end

  # DELETE /user/:id - Delete User By ID From Users List
  def destroy
    begin
      User.find(params[:id]).destroy!
    rescue ActiveRecord::RecordNotFound
      return render json: { "error": "User not found, Please enter valid user id" }, status: 400
    rescue Exception => exc
      return render json: { "error": exc.message }, status: 500
    end
    render status: 200
  end

  # Authenticate /user/login - Authenticate User
  def userLogin
    #TODO Authenticate User
  end

  #GET /user/:id/watchlist - Get User Movies Watchlist
  def getUserMovieWatchList
    user_movies = User.find(params[:id]).movies
    render json: user_movies, status: 200
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
