class GenresController < ApplicationController
  # GET /genre - Get All Genres List
  def index
    render json: Genre.all
  end

  # GET /genre/:id - Get Genre By ID From Genres List
  def show
    render json: Genre.find(params[:id])
  end

  # POST /genre - Add A New Genre To Genres List
  def create
    genre = Genre.create(genre_params)
    render json: genre
  end
  
  # PUT/PATCH /genre/:id - Update A Genre By ID From Genres List
  def update
    begin
      @genre = Genre.update(genre_params)
    rescue
      return render status: 500
    end
    render json: @genre, status: 202
  end

  # DELETE /genre/:id - Delete Genre By ID From Genres List
  def destroy
    Genre.find(params[:id]).destroy!
    render json: {}, status: 200
  end

  private

  def genre_params
    params.permit(:genre)
  end
end
