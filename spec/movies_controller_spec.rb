require 'rails_helper'
describe MoviesController, type: :controller do
  describe "GET index" do
    it "have 200 response for getting all movies" do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end
  describe "GET show" do
    it "have 200 response for getting all movies" do
      get :show, params: { id: 2 }
      expect(response).to have_http_status(:ok)
    end
  end
end