require 'rails_helper'

RSpec.describe 'Children', type: :request do
  before do
    @user = FactoryBot.create(:user)
    sign_in @user
    @child = FactoryBot.create(:child, name: '太郎', gender: :male, blood_type: :A, user: @user)
  end

  describe 'GET /index' do
    it '正常にレスポンスが返ってくる' do
      get children_path
      expect(response.status).to eq 200
    end

    it '子供の名前が表示されている' do
      get children_path
      expect(response.body).to include('太郎')
    end

    it '子供の性別が表示されている' do
      get children_path
      expect(response.body).to include('男の子')
    end

    it '子供の血液型が表示されている' do
      get children_path
      expect(response.body).to include('A型')
    end
  end
end
