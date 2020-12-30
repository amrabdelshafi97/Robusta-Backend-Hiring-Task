class ActorsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render json: Actor.all, status: 200
  end

  def show
    render json: Actor.find(params[:id])
  end

  def create
    actor = Actor.create(actor_params)
    render json: actor
  end

  def destroy
    Actor.find(params[:id]).destroy!
    render json: {}, status: 200
  end

  private

  def actor_params
    params.permit(:display_name, :first_name, :last_name, :gender, :birthdate, :deathdate)
  end
end
