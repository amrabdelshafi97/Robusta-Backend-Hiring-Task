require 'rails_helper'
describe GenresController, type: :controller do
  genre = Genre.create(:genre => "Action")
  describe "GET index" do
    it "have 200 response for getting all genres" do
      get :index
      expect(response).to have_http_status(200)
    end
  end
  describe "GET show" do
    it "have 200 response for getting genre by id" do
      get :show, :params => { :id => genre.id }
      expect(response).to have_http_status(200)
    end
    it "have 400 response for getting genre by invalid id" do
      get :show, :params => { :id => -1 }
      expect(response).to have_http_status(400)
    end
  end
  describe "POST create" do
    it "have 200 response for creating new genre" do
      post :create, :params => { :genre => "Drama" }
      expect(response).to have_http_status(200)
    end
    it "have 400 response for creating invalid genre" do
      post :create, :params => { :genre => "a" }
      expect(response).to have_http_status(400)
    end
  end
  describe "PUT update" do
    it "have 200 response for updating genre" do
      put :update, :params => { :id => genre.id, :genre => "Sci-Fi" }
      expect(response).to have_http_status(200)
    end
    it "have 400 response for updating invalid genre" do
      post :update, :params => { :id => -1, :genre => "Horror" }
      expect(response).to have_http_status(400)
    end
    it "have 400 response for updating invalid genre" do
      post :update, :params => { :id => genre.id, :genre => "a" }
      expect(response).to have_http_status(400)
    end
  end
  describe "DELETE destroy" do
    it "have 200 response for deleting genre by id" do
      genre = Genre.create(genre: "Comedy")
      delete :destroy, :params => { :id => genre.id }
      expect(response).to have_http_status(200)
    end
    it "have 400 response for deleting genre by invalid id" do
      delete :destroy, id: -1
      expect(response).to have_http_status(400)
    end
  end
end