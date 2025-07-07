require 'rails_helper'

RSpec.describe "HeightWeights", type: :request do
  let(:user) {create(:user)}
  let!(:child) { create(:child, user: user) }

  before do
    sign_in user
    post select_child_path, params: { child_id: child.id }
  end

  describe "GET /children/:child_id/height_weights/new" do
    it "returns http success" do
      get new_child_height_weight_path(child)
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /children/:child_id/height_weights" do
    context "有効なパラメータの場合" do
      let(:valid_params) {
        {
          height_weight: {
            recorded_on: Date.today,
            height: 100,
            weight: 15
          }
        }
      }

      it "登録が成功してリダイレクトされること" do
        post child_height_weights_path(child), params: valid_params
        expect(response).to redirect_to(child_height_weights_path(child))
        follow_redirect!
      end
    end

    context "無効なパラメータの場合" do
      let(:invalid_params) {
        {
          height_weight: {
            recorded_on: nil,
            height: nil,
            weight: nil
          }
        }
      }

      it "再レンダリングされること" do
        post child_height_weights_path(child), params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity).or have_http_status(:ok)
        expect(response.body).to include("身長か体重のどちらかを入力してください")
      end
    end
  end

  describe "GET /children/:child_id/height_weights" do
    it "正常に一覧画面が表示されること" do
      get child_height_weights_path(child)
      expect(response).to have_http_status(:success)
      expect(response.body).to include("身長体重記録")
    end
  end
end
