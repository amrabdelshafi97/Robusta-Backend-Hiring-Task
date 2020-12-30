  class DirectorsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
      render json: Director.all, status: 200
    end

    def show
      #TODO handle if id not found
      render json: Director.find(params[:id])
    end

    def create
      director = Director.create(director_param)
      render json: director
    end

    def destroy
      Director.find(params[:id]).destroy!
      render json: {}, status: 204
    end

    private

    def director_param
      params.permit(:display_name, :birthdate, :deathdate, :biography,:place_of_birth)
    end
  end
