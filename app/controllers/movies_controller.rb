class MoviesController < ApplicationController
  skip_before_action :verify_authenticity_token

  # GET /movie - Get All Movies List
  # GET /movie?category=genre - Get All Movies List Categorized Bu "genre"
  # GET /movie?sort=release_date - Get All Movies List Sorted By "release_date"
  # GET /movie?week_limit=1 - Get All Movies List Released Within "1" week
  # GET /movie?featured=true - Get All Featured Movies List
  def index
    @movies = Movie.all
    query_params = request.query_parameters

    if query_params.has_key?("category")
      category_opt = query_params["category"]
      @movies = @movies.group_by { |movie| movie[category_opt] }
    end

    if query_params.has_key?("sort")
      sort_opt = query_params["sort"]
      @movies = @movies.sort_by { |movie| movie[sort_opt] }
    end

    if query_params.has_key?("week_limit")
      week_limit_no = query_params["week_limit"]
      @movies = @movies.where('release_date > ?', (DateTime.now - week_limit_no.week))
    end

    if query_params.has_key?("featured")
      is_featured = ActiveModel::Type::Boolean.new.cast(query_params["featured"])
      @movies = @movies.where(featured: is_featured)
    end

    render json: @movies, status: 200
  end

  # GET /movie/:id - Get Movie By ID From Movies List
  def show
    movie_id = params[:id]
    if Movie.exists?(id: movie_id)
      return render json: Movie.find(movie_id), status: 200
    end
    render json: "Movie Not Found", status: 404
  end

  # POST /movie - Add A New Movie To Movies List
  def create
    movie = Movie.create(movie_params)

    params.has_key?("actors_ids") && params["actors_ids"].each do
    |actor_id|
      if Celebrity.exists?(id: actor_id, type: "actor")
        movie.movie_celebrities.build({ celebrity_id: actor_id })
      end
    end

    params.has_key? ("awards_ids") && params["awards_ids"].each do
    |award_id|
      if Award.exists?(id: award_id)
        movie.movie_awards.build({ award_id: award_id })
      end
    end

    params.has_key? ("genres_ids") && params["genres_ids"].each do
    |genre_id|
      if Genre.exists?(id: genre_id)
        movie.movie_genres.build({ genre_id: genre_id })
      end
    end

    if params.has_key?("director_id")
      director_id = params["director_id"]
      if Celebrity.exists?(id: director_id, type: "director")
        movie.director_id = director_id
      end
    end

    movie.save!
    render json: movie, status: 201
  end

  # PUT/PATCH /movie/:id - Upadate A Movie By ID From Movies List
  # User Can Use This To Add/Remove Movies To/From Featured Movies List
  def update
    begin
      @movie = Movie.update(movie_params)
    rescue
      return render status: 500
    end
    render json: @movie, status: 202
  end

  # Delete /movie/:id - Delete Movie By ID From Movies List
  def destroy
    movie_id = params[:id]
    if Movie.exists?(id: movie_id)
      Movie.find(movie_id).destroy!
      return render json: "Movie Deleted Successfully", status: 204
    end
    render json: "Movie Not Found", status: 404
  end

  private

  def movie_params
    params.permit(:title, :description, :rating, :release_date, :film_rate, :featured)
  end

  def movie_details_params
    params.permit(:actors_ids, :awards_ids, :genres_ids, :director_id)
  end
end
