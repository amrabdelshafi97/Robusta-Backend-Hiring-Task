class CelebritiesController < ApplicationController
  # GET /celebrity - Get All Celebrities List
  def index
    render json: Celebrity.all, status: 200
  end

  # GET /celebrity/:id - Get Celebrity By ID From Celebrities List
  def show
    render json: Celebrity.find(params[:id])
  end

  # POST /celebrity - Add A New Celebrity To Celebrities List
  def create
    actor = Celebrity.create(actor_params)
    render json: actor
  end

  # PUT/PATCH /celebrity/id - Update A Celebrity By ID From Celebrities List
  def update
    begin
      @celebrity = Award.update(award_params)
    rescue
      return render status: 500
    end
    render json: @celebrity, status: 202
  end

  # Delete /celebrity/:id - Delete Celebrity By ID From Celebrities List
  def destroy
    Celebrity.find(params[:id]).destroy!
    render json: {}, status: 200
  end

  private

  def actor_params
    params.permit(:display_name, :first_name, :last_name, :gender, :birthdate, :deathdate, :nationality, :celebrity_type, :biography, :place_of_birth)
  end
end
