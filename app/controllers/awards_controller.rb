class AwardsController < ApplicationController
  # GET /award - Get All Awards List
  def index
    begin
      awards = Award.all
    rescue Exception => exc
      return render json: { error => exc.message }, status: 500
    end
    render json: awards, status: 200
  end

  # GET /award/:id - Get Award By ID From Awards List
  def show
    begin
      @award = Award.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      return render json: { "error": "Award not found, Please enter valid award id" }, status: 400
    rescue Exception => exc
      return render json: { "error": exc.message }, status: 500
    end
    render json: @award, status: 200
  end

  # POST /award - Add A New Award To Awards List
  def create
    begin
      award = Award.create(award_params)
      if award.errors.size > 0
        return render json: award.errors, status: 400
      end
    rescue Exception => exc
      return render json: { "error" => exc.message }, status: 500
    end
    render json: award, status: 200
  end

  # PUT/PATCH /award/:id - Update An Award By ID From Awards List
  def update
    begin
      Award.find(params[:id])
      award = Award.update(award_params)
      if award.errors.size > 0
        return render json: award.errors, status: 400
      end
    rescue ActiveRecord::RecordNotFound
      return render json: { "error": "Award not found, Please enter valid award id" }, status: 400
    rescue Exception => exc
      return render json: { "error" => exc.message }, status: 500
    end
    render json: award, status: 200
  end

  # DELETE /award/:id - Delete Award By ID From Awards List
  def destroy
    begin
      Award.find(params[:id]).destroy!
    rescue ActiveRecord::RecordNotFound
      return render json: { "error": "Award not found, Please enter valid award id" }, status: 400
    rescue Exception => exc
      return render json: { "error": exc.message }, status: 500
    end
    render status: 200
  end

  private

  def award_params
    params.permit(:award)
  end
end
