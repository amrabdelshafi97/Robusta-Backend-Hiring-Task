class CelebritiesController < ApplicationController
  # GET /celebrity - Get All Celebrities List
  def index
    begin
      celebrities = Celebrity.all
    rescue Exception => exc
      return render json: { error => exc.message }, status: 500
    end
    render json: celebrities, status: 200
  end

  # GET /celebrity/:id - Get Celebrity By ID From Celebrities List
  def show
    begin
      celebrity = Celebrity.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      return render json: { "error": "Celebrity not found, Please enter valid celebrity id" }, status: 400
    rescue Exception => exc
      return render json: { "error": exc.message }, status: 500
    end
    render json: celebrity, status: 200
  end

  # POST /celebrity - Add A New Celebrity To Celebrities List
  def create
    begin
      celebrity = Celebrity.create(celebrity_params)
      if celebrity.errors.size > 0
        return render json: celebrity.errors, status: 400
      end
    rescue Exception => exc
      return render json: { "error" => exc.message }, status: 500
    end
    render json: celebrity, status: 200
  end

  # PUT/PATCH /celebrity/id - Update A Celebrity By ID From Celebrities List
  def update
    begin
      Celebrity.find(params[:id])
      celebrity = Celebrity.update(award_params)
      if celebrity.errors.size > 0
        return render json: celebrity.errors, status: 400
      end
    rescue ActiveRecord::RecordNotFound
      return render json: { "error": "Celebrity not found, Please enter valid celebrity id" }, status: 400
    rescue Exception => exc
      return render json: { "error" => exc.message }, status: 500
    end
    render json: celebrity, status: 200
  end

  # DELETE /celebrity/:id - Delete Celebrity By ID From Celebrities List
  def destroy
    begin
      Celebrity.find(params[:id]).destroy!
    rescue ActiveRecord::RecordNotFound
      return render json: { "error": "Celebrity not found, Please enter valid celebrity id" }, status: 400
    rescue Exception => exc
      return render json: { "error": exc.message }, status: 500
    end
    render status: 200
  end

  # GET /celebrity/search?query=something - Search In News Content About Word "something"
  def search
    begin
      return render json: "Please enter query", status: 400 unless request.query_parameters['query']
      query = request.query_parameters['query']
      celebrities = Celebrity.search_celebrity(query)
    rescue Exception => exc
      return render json: { "error": exc.message }, status: 500
    end
    render json: celebrities, status: 200
  end

  private

  def celebrity_params
    params.permit(:display_name, :first_name, :last_name, :gender, :birthdate, :deathdate, :nationality, :celebrity_type, :biography, :place_of_birth)
  end
end
