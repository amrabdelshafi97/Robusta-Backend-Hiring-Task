class MoviesController < ApplicationController
  # GET /movie - Get All Movies List
  # GET /movie?category=genre - Get All Movies List Categorized Bu "genre"
  # GET /movie?sort=release_date - Get All Movies List Sorted By "release_date"
  # GET /movie?week_limit=1 - Get All Movies List Released Within "1" week
  # GET /movie?featured=true - Get All Featured Movies List
  def index
    begin
      movies = Movie.all
      query_params = request.query_parameters

      if query_params.has_key?("category")
        category_opt = query_params["category"]
        movies = movies.group_by { |movie| movie[category_opt] }
      end

      if query_params.has_key?("sort")
        sort_opt = query_params["sort"]
        movies = movies.sort_by { |movie| movie[sort_opt] }
      end

      if query_params.has_key?("week_limit")
        week_limit_no = query_params["week_limit"]
        movies = movies.where('release_date > ?', week_limit_no.week.ago)
      end

      if query_params.has_key?("featured")
        is_featured = ActiveModel::Type::Boolean.new.cast(query_params["featured"])
        movies = movies.where(featured: is_featured)
      end
    rescue Exception => exc
      return render json: { "error": exc.message }, status: 500
    end

    render json: movies, status: 200
  end

  # GET /movie/:id - Get Movie By ID From Movies List
  def show
    begin
      movie = Movie.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      return render json: { "error": "Movie not found, Please enter valid movie id" }, status: 400
    rescue Exception => exc
      return render json: { "error": exc.message }, status: 500
    end
    render json: movie, status: 200
  end

  # POST /movie - Add A New Movie To Movies List
  def create
    begin
      movie = Movie.create(movie_params)

      params["actors_ids"].present? && params["actors_ids"].each do
      |actor_id|
        if Celebrity.exists?(id: actor_id, celebrity_type: "celebrity")
          movie.movie_celebrities.build({ celebrity_id: actor_id })
        end
      end

      params["awards_ids"].present? && params["awards_ids"].each do
      |award_id|
        if Award.exists?(id: award_id)
          movie.movie_awards.build({ award_id: award_id })
        end
      end

      params["genres_ids"].present? && params["genres_ids"].each do
      |genre_id|
        if Genre.exists?(id: genre_id)
          movie.movie_genres.build({ genre_id: genre_id })
        end
      end

      if movie.errors.size > 0
        return render json: movie.errors, status: 400
      end
    rescue Exception => exc
      return render json: { "error" => exc.message }, status: 500
    end
    movie.save!
    render json: movie, status: 200

  end

  # PUT/PATCH /movie/:id - Update A Movie By ID From Movies List
  # User Can Use This To Add/Remove Movies To/From Featured Movies List
  def update
    begin
      Movie.find(params[:id])
      movie = Movie.update(movie_params)

      params["actors_ids"].present? && params["actors_ids"].each do
      |actor_id|
        if Celebrity.exists?(id: actor_id, celebrity_type: "celebrity")
          movie.movie_celebrities.build({ celebrity_id: actor_id })
        end
      end

      params["awards_ids"].present? && params["awards_ids"].each do
      |award_id|
        if Award.exists?(id: award_id)
          movie.movie_awards.build({ award_id: award_id })
        end
      end

      params["genres_ids"].present? && params["genres_ids"].each do
      |genre_id|
        if Genre.exists?(id: genre_id)
          movie.movie_genres.build({ genre_id: genre_id })
        end
      end

      if params["director_id"].present?
        director_id = params["director_id"]
        if Celebrity.exists?(id: director_id, celebrity_type: "director")
          movie.director_id = director_id
        end
      end
      if movie.errors.size > 0
        return render json: movie.errors, status: 400
      end
    rescue ActiveRecord::RecordNotFound
      return render json: { "error": "Movie not found, Please enter valid movie id" }, status: 400
    rescue Exception => exc
      return render json: { "error" => exc.message }, status: 500
    end
    movie.save!
    render json: movie, status: 200
  end

  # DELETE /movie/:id - Delete Movie By ID From Movies List
  def destroy
    begin
      Movie.find(params[:id]).destroy!
    rescue ActiveRecord::RecordNotFound
      return render json: { "error": "Movie not found, Please enter valid movie id" }, status: 400
    rescue Exception => exc
      return render json: { "error": exc.message }, status: 500
    end
    render status: 200
  end

  # post /movie/:id/rate - Add User Rate from 0 to 10 To A Movie
  def addMovieRate
    begin
      Movie.find(params[:id])
      req_params = movie_user_rate_params
      movie_id = params[:id]
      movie = Movie.find(movie_id)
      movie.user_movie_rates.build({ user_id: req_params["user_id"], rate: req_params["rate"] }).save!
    rescue ActiveRecord::RecordNotFound
      return render json: { "error": "Movie not found, Please enter valid movie id" }, status: 400
    rescue Exception => exc
      return render json: { "error" => exc.message }, status: 500
    end
    render json: "Rate Submitted", status: 200
  end

  # post /movie/:id/watchlist - Add A Movie For A User Watchlist
  def addMovieToUserWatchlist
    begin
      Movie.find(params[:id])
      req_params = movie_user_rate_params
      movie_id = params[:id]
      movie = Movie.find(movie_id)
      movie.watchlists.build({ user_id: req_params["user_id"] }).save!
    rescue ActiveRecord::RecordNotFound
      return render json: { "error": "Movie not found, Please enter valid movie id" }, status: 400
    rescue Exception => exc
      return render json: { "error" => exc.message }, status: 500
    end

    render json: "Added To Watchlist", status: 200
  end

  # post /movie/:id/review - Add A User Review/Review On A Movie
  def addUserReviewToMovie
    begin
      Movie.find(params[:id])
      req_params = movie_user_rate_params
      movie_id = params[:id]
      movie = Movie.find(movie_id)
      movie.reviews.build({ user_id: req_params["user_id"], review: req_params["review"] }).save!
    rescue ActiveRecord::RecordNotFound
      return render json: { "error": "Movie not found, Please enter valid movie id" }, status: 400
    rescue Exception => exc
      return render json: { "error" => exc.message }, status: 500
    end
    render json: "Review Submitted", status: 200
  end

  # GET /movie/search?query=something - Search In News Content About Word "something"
  def search
    begin
      return render json: "Please enter query", status: 400 unless request.query_parameters['query']
      query = request.query_parameters['query']
      movies = Movie.search_movie_title(query)
    rescue Exception => exc
      return render json: { "error" => exc.message }, status: 500
    end

    render json: movies, status: 200
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :description, :release_date, :film_rate_id, :featured, :actors_ids, :awards_ids, :genres_ids, :director_id, :poster_path, :language)
  end

  def movie_details_params
    params.permit(:actors_ids, :awards_ids, :genres_ids, :director_id)
  end

  def movie_user_rate_params
    params.permit(:user_id, :rate)
  end

  def movie_user_watchlist_params
    params.permit(:user_id)
  end

  def movie_user_review_params
    params.permit(:user_id, :review)
  end
end
