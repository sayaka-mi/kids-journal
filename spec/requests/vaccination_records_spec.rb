require 'rails_helper'

RSpec.describe "VaccinationRecords", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/vaccination_records/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/vaccination_records/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/vaccination_records/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/vaccination_records/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/vaccination_records/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
