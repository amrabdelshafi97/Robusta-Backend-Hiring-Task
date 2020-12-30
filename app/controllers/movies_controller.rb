class MoviesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @res = Movie.where('release_date > ?', (DateTime.now - 1.week))
    render json: @res
  end

  def show
    render json: Movie.find(params[:id])
  end

  def create
    movie = Movie.create(movie_params)
    params.has_key?("actors_ids") && params["actors_ids"].each do
    |actor_id|
      movie.movie_actors.build({ actor_id: actor_id })
    end

    params.has_key? ("awards_ids") && params["awards_ids"].each do
    |award_id|
      movie.movie_awards.build({ award_id: award_id })
    end

    params.has_key? ("genres_ids") && params["genres_ids"].each do
    |genre_id|
      movie.movie_genres.build({ genre_id: genre_id })
    end

    movie.director_id = params.has_key? ("director_id") && params["director_id"]
    movie.save!
    render json: movie
  end

  def destroy
    movie = Movie.find(params[:id])
    movie.destroy!
    render json: {}, status: 200
  end

  private

  def movie_params
    params.permit(:title, :description, :rating, :release_date, :film_rate, :featured)
  end

  def movie_details_params
    params.permit(:actors_ids, :awards_ids, :genres_ids, :director_id)
  end
end
