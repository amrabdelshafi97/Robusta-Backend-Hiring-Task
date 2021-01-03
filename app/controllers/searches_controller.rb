class SearchesController < ApplicationController
  def search
    begin
      return render json: "Please enter query", status: 400 unless request.query_parameters['query']
      query = request.query_parameters['query']
      @movies = Movie.search_movie_title(query)
      @news = News.search_news_content(query)
      @celebrities = Celebrity.search_celebrity(query)
    rescue Exception => exc
      return render json: { "error" => exc.message }, status: 500
    end
  end
end