class NewsController < ApplicationController
  # GET /news - Get All News List
  def index
    render json: News.all, status: 200
  end

  # GET /news/:id - Get Award By ID From Awards List
  def show
    render json: News.find(params[:id]), status: 200
  end

  # POST /news - Add A News Award To News List
  def create
    @news = News.create(news_params)
    #TODO Create Validation on News "date" param
    #TODO Handle DB Queries Try/Catch If Error
    render json: @news
  end

  # PUT/PATCH /news/:id - Update A News By ID From News List
  def update
    begin
      @news = News.update(award_params)
    rescue
      return render status: 500
    end
    render json: @news, status: 202
  end

  # DELETE /news/:id - Delete News By ID From News List
  def destroy
    # handled if "id" not found
    begin
      News.find(params[:id]).destroy!
    rescue
      render json: "News ID Not Found", status: 404
    end
    render json: {}, status: 204
  end

  # GET /news?query=something - Search In News Content About Word "something"
  def search
    return unless request.query_parameters['query']
    query = request.query_parameters['query']
    news = News.search_news_content(query)
    render json: news
  end

  private

  def news_params
    params.permit(:title, :description, :date, :content)
  end
end
