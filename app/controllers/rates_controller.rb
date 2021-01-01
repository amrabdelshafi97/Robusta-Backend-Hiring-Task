class RatesController < ApplicationController
  # GET /rate - Get All Rates List
  def index
    begin
      rates = Rate.all
    rescue Exception => exc
      return render json: { error => exc.message }, status: 500
    end
    render json: rates, status: 200
  end

  # GET /rate/:id - Get Rate By ID From Rates List
  def show
    begin
      rate = Rate.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      return render json: { "error": "Rate not found, Please enter valid rate id" }, status: 400
    rescue Exception => exc
      return render json: { "error": exc.message }, status: 500
    end
    render json: rate, status: 200
  end

  # POST /rate - Add A New Rate To Rates List
  def create
    begin
      rate = Rate.create(rate_params)
      if rate.errors.size > 0
        return render json: rate.errors, status: 400
      end
    rescue Exception => exc
      return render json: { "error" => exc.message }, status: 500
    end
    render json: rate, status: 200
  end

  # PUT/PATCH /rate/:id - Update An Rate By ID From Rates List
  def update
    begin
      Rate.find(params[:id])
      rate = Rate.update(rate_params)
      if Rate.errors.size > 0
        return render json: rate.errors, status: 400
      end
    rescue ActiveRecord::RecordNotFound
      return render json: { "error": "Rate not found, Please enter valid rate id" }, status: 400
    rescue Exception => exc
      return render json: { "error" => exc.message }, status: 500
    end
    render json: rate, status: 200
  end

  # DELETE /rate/:id - Delete Rate By ID From Rates List
  def destroy
    begin
      Rate.find(params[:id]).destroy!
    rescue ActiveRecord::RecordNotFound
      return render json: { "error": "Rate not found, Please enter valid rate id" }, status: 400
    rescue Exception => exc
      return render json: { "error": exc.message }, status: 500
    end
    render status: 200
  end

  private

  def rate_params
    params.permit(:rate)
  end
end
