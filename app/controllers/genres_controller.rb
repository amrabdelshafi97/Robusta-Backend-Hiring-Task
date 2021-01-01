class GenresController < ApplicationController
  # GET /genre - Get All Genres List
  def index
    begin
      genres = Genre.all
    rescue Exception => exc
      return render json: { error => exc.message }, status: 500
    end
    render json: genres, status: 200
  end

  # GET /genre/:id - Get Genre By ID From Genres List
  def show
    begin
      genre = Genre.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      return render json: { "error": "Genre not found, Please enter valid Genre id" }, status: 400
    rescue Exception => exc
      return render json: { "error": exc.message }, status: 500
    end
    render json: genre, status: 200
  end

  # POST /genre - Add A New Genre To Genres List
  def create
    begin
      genre = Genre.create(Genre_params)
      if genre.errors.size > 0
        return render json: genre.errors, status: 400
      end
    rescue Exception => exc
      return render json: { "error" => exc.message }, status: 500
    end
    render json: genre, status: 200
  end

  # PUT/PATCH /genre/:id - Update An Genre By ID From Genres List
  def update
    begin
      Genre.find(params[:id])
      genre = Genre.update(genre_params)
      if Genre.errors.size > 0
        return render json: genre.errors, status: 400
      end
    rescue ActiveRecord::RecordNotFound
      return render json: { "error": "Genre not found, Please enter valid genre id" }, status: 400
    rescue Exception => exc
      return render json: { "error" => exc.message }, status: 500
    end
    render json: genre, status: 200
  end

  # DELETE /genre/:id - Delete Genre By ID From Genres List
  def destroy
    begin
      Genre.find(params[:id]).destroy!
    rescue ActiveRecord::RecordNotFound
      return render json: { "error": "Genre not found, Please enter valid genre id" }, status: 400
    rescue Exception => exc
      return render json: { "error": exc.message }, status: 500
    end
    render status: 200
  end

  private

  def genre_params
    params.permit(:genre)
  end
end
