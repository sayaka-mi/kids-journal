require 'rails_helper'

RSpec.describe 'Tags', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/tags'
      expect(response).to have_http_status(:success)
    end
  end
end
