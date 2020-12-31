class AwardsController < ApplicationController
  skip_before_action :verify_authenticity_token

  # GET /award - Get All Awards List
  def index
    render json: Award.all
  end

  # GET /award/:id - Get Award By ID From Awards List
  def show
    render json: Award.find(params[:id])
  end

  # POST /award - Add A New Award To Awards List
  def create
    award = Award.create(award_params)
    render json: award
  end

  # PUT/PATCH /award/:id - Update An Award By ID From Awards List
  def update
    begin
      @award = Award.update(award_params)
    rescue
      return render status: 500
    end
    render json: @award, status: 202
  end

  # Delete /award/:id - Delete Award By ID From Awards List
  def destroy
    Award.find(params[:id]).destroy!
    render json: {}, status: 204
  end

  private

  def award_params
    params.permit(:award)
  end
end
