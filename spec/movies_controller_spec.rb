require 'rails_helper'
describe MoviesController, type: :controller do
  describe "GET index" do
    it "returns 200 response for getting all movies" do
      get :index
      expect(response).to have_http_status(200)
    end
  end
  describe "GET show" do
    it "returns 200 response for getting movie by id" do
      # make sure that the id supported is found at the Database
      get :show, params: { id: 1 }
      expect(response).to have_http_status(200)
    end
    it "returns 400 response for getting movie by not valid id" do
      get :show, params: { id: -100 }
      expect(response).to have_http_status(400)
    end
  end
  describe "POST create" do
    it "returns 200 response for Inserting Movie with valid data" do
      Rate.create(rate: "G")
      Celebrity.create(display_name: "Tom Hanks", first_name: "Tom", last_name: "Hanks", gender: "male", birthdate: "1990-10-10", deathdate: nil, nationality: "american", celebrity_type: "director", biography: "This is director test biography", place_of_birth: "America")
      post :create, params: { title: "Test Movie Title", description: "Test Movie Description", release_date: "2020-12-12", film_rate_id: 1, director_id: 1, poster_path: "test_path.png", language: "english" }
      expect(response).to have_http_status(200)
    end
    it "returns 400 response for Inserting Movie with not valid data" do
      post :create, params: { title: "Test Movie Title", release_date: 3, film_rate_id: 1, director_id: 1, poster_path: "test_path.png", language: "english" }
      expect(response).to have_http_status(400)
    end
  end
end