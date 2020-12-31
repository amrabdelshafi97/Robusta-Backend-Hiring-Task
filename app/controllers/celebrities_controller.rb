class CelebritiesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render json: Celebrity.all, status: 200
  end

  def show
    render json: Celebrity.find(params[:id])
  end

  def create
    actor = Celebrity.create(actor_params)
    render json: actor
  end

  def destroy
    Celebrity.find(params[:id]).destroy!
    render json: {}, status: 200
  end

  private

  def actor_params
    params.permit(:display_name, :first_name, :last_name, :gender, :birthdate, :deathdate)
  end
end
