module Movies
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
      @movie = Movie.create(movie_params)
      render json: @movie
    end

    def destroy
      movie = Movie.find(params[:id])
      movie.destroy!
      render json: {}, status: 200
    end

    private

    def movie_params
      params.require(:movie).permit(:title, :description,:release_date,:featured)
    end
  end
end