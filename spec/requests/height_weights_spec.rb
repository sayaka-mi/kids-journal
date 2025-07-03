require 'rails_helper'

RSpec.describe "HeightWeights", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/height_weights/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/height_weights/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /index" do
    it "returns http success" do
      get "/height_weights/index"
      expect(response).to have_http_status(:success)
    end
  end

end
