  class RatingsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
      render json: Rate.all
    end

    def show
      render json: Rate.find(params[:id])
    end

    def create
      rate = Rate.create(movie_params)
      render json: rate
    end

    def destroy
      Rate.find(params[:id]).destroy!
      render json: {}, status: 204
    end

    private

    def movie_params
      params.permit(:rate)
    end
  end
