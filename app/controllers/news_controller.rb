  class NewsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
      render json: News.all, status: 200
    end

    def show
      render json: News.find(params[:id]), status: 200
    end

    def create
      @news = News.create(news_params)
      #TODO Create Validation on News "date" param
      #TODO Handle DB Queries Try/Catch If Error
      render json: @news
    end

    def destroy
      # handled if "id" not found
      begin
        News.find(params[:id]).destroy!
      rescue
        render json: "News ID Not Found", status: 404
      end
      render json: {}, status: 204
    end

    private

    def news_params
      params.permit(:title, :description, :date, :content)
    end
  end
