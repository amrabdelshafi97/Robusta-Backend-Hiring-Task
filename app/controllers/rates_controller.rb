  class RatesController < ApplicationController
    # GET /rate - Get All Rate List
    def index
      render json: Rate.all
    end
  
    # GET /rate/:id - Get Rate By ID From Rates List
    def show
      render json: Rate.find(params[:id])
    end
  
    # POST /rate - Add A New Rate To Rates List
    def create
      rate = Rate.create(rate_params)
      render json: rate
    end

    # PUT/PATCH /rate/:id - Update A Rate By ID From Rates List
    def update
      begin
        @rate = Rate.update(rate_params)
      rescue
        return render status: 500
      end
      render json: @rate, status: 202
    end
  
    # Delete /rate/:id - Delete Rate By ID From Rates List
    def destroy
      Rate.find(params[:id]).destroy!
      render json: {}, status: 204
    end

    private

    def rate_params
      params.permit(:rate)
    end
  end
