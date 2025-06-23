require 'rails_helper'

RSpec.describe "Records", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:child) { FactoryBot.create(:child, user: user) }
  let!(:record) { FactoryBot.create(:record, child: child) }

  before do
    sign_in user
  end

  describe "GET /index" do
    it "正常にレスポンスが返ってくる" do
      get child_records_path(child)
      expect(response).to have_http_status(:ok)
    end

    it "レコードの内容が表示されている" do
      get child_records_path(child)
      expect(response.body).to include(record.content)
    end
  end

  describe "POST /create" do
    let(:valid_params) { { record: { content: "テスト記録" } } }

    it "新しい記録を作成できる" do
      expect {
        post child_records_path(child), params: valid_params
      }.to change(child.records, :count).by(1)
      expect(response).to redirect_to(child_records_path(child))
    end
  end

  describe "PATCH /update" do
    let(:update_params) { { record: { content: "更新した内容" } } }

    it "記録を更新できる" do
      patch child_record_path(child, record), params: update_params
      expect(response).to redirect_to(child_records_path(child))
      record.reload
      expect(record.content).to eq("更新した内容")
    end
  end

  describe "DELETE /destroy" do
    it "記録を削除できる" do
      expect {
        delete child_record_path(child, record)
      }.to change(child.records, :count).by(-1)
      expect(response).to redirect_to(child_records_path(child))
    end
  end
end