require 'rails_helper'
describe AwardsController, type: :controller do
  award = Award.create(:award => "Academy")
  describe "GET index" do
    it "have 200 response for getting all awards" do
      get :index
      expect(response).to have_http_status(200)
    end
  end
  describe "GET show" do
    it "have 200 response for getting award by id" do
      get :show, :params => { :id => award.id }
      expect(response).to have_http_status(200)
    end
    it "have 400 response for getting award by invalid id" do
      get :show, :params => { :id => -1 }
      expect(response).to have_http_status(400)
    end
  end
  describe "POST create" do
    it "have 200 response for creating new award" do
      post :create, :params => { :award => "Academy" }
      expect(response).to have_http_status(200)
    end
    it "have 400 response for creating invalid award" do
      post :create, :params => { :award => "a" }
      expect(response).to have_http_status(400)
    end
  end
  describe "PUT update" do
    it "have 200 response for updating" do
      put :update, :params => { :id =>award.id, :award => "AcademyUpdated" }
      expect(response).to have_http_status(200)
    end
    it "have 400 response for updating invalid award" do
      post :update, :params => { :id => -1, :award => "AcademyUpdated" }
      expect(response).to have_http_status(400)
    end
    it "have 400 response for updating invalid award" do
      post :update, :params => { :id => award.id, :award => "a" }
      expect(response).to have_http_status(400)
    end
  end
  describe "DELETE destroy" do
    it "have 200 response for deleting award by id" do
      award = Award.create(award: "Oscar")
      delete :destroy, :params => { :id => award.id }
      expect(response).to have_http_status(200)
    end
    it "have 400 response for deleting award by invalid id" do
      delete :destroy, id: -1
      expect(response).to have_http_status(400)
    end
  end
end