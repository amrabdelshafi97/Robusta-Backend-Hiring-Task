class AwardsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render json: Award.all
  end

  def show
    render json: Award.find(params[:id])
  end

  def create
    award = Award.create(award_params)
    render json: award
  end

  def destroy
    Award.find(params[:id]).destroy!
    render json: {}, status: 204
  end

  private

  def award_params
    params.permit(:award)
  end
end
