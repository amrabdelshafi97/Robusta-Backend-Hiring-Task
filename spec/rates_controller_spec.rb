require 'rails_helper'
describe RatesController, type: :controller do
  rate = Rate.create(:rate => "PG-13")
  describe "GET index" do
    it "have 200 response for getting all rates" do
      get :index
      expect(response).to have_http_status(200)
    end
  end
  describe "GET show" do
    it "have 200 response for getting rate by id" do
      get :show, :params => { :id => rate.id }
      expect(response).to have_http_status(200)
    end
    it "have 400 response for getting rate by invalid id" do
      get :show, :params => { :id => -1 }
      expect(response).to have_http_status(400)
    end
  end
  describe "POST create" do
    it "have 200 response for creating new rate" do
      post :create, :params => { :rate => "PG" }
      expect(response).to have_http_status(200)
    end
    it "have 400 response for creating invalid rate" do
      post :create, :params => { :rate => "a" }
      expect(response).to have_http_status(400)
    end
  end
  describe "PUT update" do
    it "have 200 response for updating rate" do
      put :update, :params => { :id =>rate.id, :rate => "PG" }
      expect(response).to have_http_status(200)
    end
    it "have 400 response for updating invalid rate" do
      post :update, :params => { :id => -1, :rate => "PG" }
      expect(response).to have_http_status(400)
    end
    it "have 400 response for updating invalid rate" do
      post :update, :params => { :id => rate.id, :rate => "A" }
      expect(response).to have_http_status(400)
    end
  end
  describe "DELETE destroy" do
    it "have 200 response for deleting rate by id" do
      rate = Rate.create(rate: "PG")
      delete :destroy, :params => { :id => rate.id }
      expect(response).to have_http_status(200)
    end
    it "have 400 response for deleting rate by invalid id" do
      delete :destroy, id: -1
      expect(response).to have_http_status(400)
    end
  end
end