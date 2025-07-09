require 'rails_helper'

RSpec.describe "SharedUsers", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/shared_users/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/shared_users/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/shared_users/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
