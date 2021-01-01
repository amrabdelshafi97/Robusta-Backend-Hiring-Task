class NewsController < ApplicationController
  # GET /news - Get All News List
  def index
    begin
      news = News.all
    rescue Exception => exc
      return render json: { error => exc.message }, status: 500
    end
    render json: news, status: 200
  end

  # GET /news/:id - Get News By ID From News List
  def show
    begin
      news = News.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      return render json: { "error": "News not found, Please enter valid news id" }, status: 400
    rescue Exception => exc
      return render json: { "error": exc.message }, status: 500
    end
    render json: news, status: 200
  end

  # POST /news - Add A New News To News List
  def create
    begin
      news = News.create(news_params)
      if news.errors.size > 0
        return render json: news.errors, status: 400
      end
    rescue Exception => exc
      return render json: { "error" => exc.message }, status: 500
    end
    render json: news, status: 200
  end

  # PUT/PATCH /news/id - Update A News By ID From News List
  def update
    begin
      News.find(params[:id])
      news = News.update(award_params)
      if news.errors.size > 0
        return render json: news.errors, status: 400
      end
    rescue ActiveRecord::RecordNotFound
      return render json: { "error": "News not found, Please enter valid news id" }, status: 400
    rescue Exception => exc
      return render json: { "error" => exc.message }, status: 500
    end
    render json: news, status: 200
  end

  # DELETE /news/:id - Delete News By ID From News List
  def destroy
    begin
      News.find(params[:id]).destroy!
    rescue ActiveRecord::RecordNotFound
      return render json: { "error": "News not found, Please enter valid news id" }, status: 400
    rescue Exception => exc
      return render json: { "error": exc.message }, status: 500
    end
    render status: 200
  end

  # GET /news/search?query=something - Search In News Content About Word "something"
  def search
    begin
      return render json: "Please enter query", status: 400 unless request.query_parameters['query']
      query = request.query_parameters['query']
      news = News.search_news_content(query)
    rescue Exception => exc
      return render json: { "error": exc.message }, status: 500
    end
    render json: news, status: 200
  end

  private

  def news_params
    params.permit(:title, :subtitle, :date, :content)
  end
end
