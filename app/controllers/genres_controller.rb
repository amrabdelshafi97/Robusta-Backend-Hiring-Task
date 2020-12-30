class GenresController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render json: Genre.all
  end

  def show
    render json: Genre.find(params[:id])
  end

  def create
    genre = Genre.create(genre_params)
    render json: genre
  end

  def destroy
    Genre.find(params[:id]).destroy!
    render json: {}, status: 200
  end

  private

  def genre_params
    params.permit(:genre)
  end
end
