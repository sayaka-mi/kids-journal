require 'rails_helper'

RSpec.describe 'VaccinationRecords', type: :request do
  let!(:user) { create(:user) }
  let!(:child) { create(:child, user: user) }
  let!(:vaccine1) { create(:vaccine, name: 'ワクチンA', recommended_doses: 2) }
  let!(:vaccine2) { create(:vaccine, name: 'ワクチンB', recommended_doses: 1) }

  before do
    sign_in user
  end

  describe 'GET //children/:child_id/vaccination_records' do
    it '予防接種記録の一覧ページを表示できること' do
      get child_vaccination_records_path(child)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("#{child.name}の予防接種きろく")
    end
  end

  describe 'POST /children/:child_id/vaccination_records/create_or_update' do
    context '有効なパラメータの場合' do
      it '新しい予防接種記録を作成し、リダイレクトすること' do
        valid_params = {
          '[vaccination_records]' => {
            '0' => {
              'vaccine_id' => vaccine1.id.to_s,
              'vaccinated_at' => '2025-07-01',
              'hospital_name' => '新規病院',
              'memo' => '新規メモ',
              'completed' => 'true'
            }
          }
        }
        expect do
          post create_or_update_child_vaccination_records_path(child), params: valid_params
        end.to change(VaccinationRecord, :count).by(1)
        expect(response).to redirect_to(child_vaccination_records_path(child))
        expect(flash[:notice]).to eq '予防接種記録を保存しました。'
      end

      it '既存の予防接種記録を更新し、リダイレクトすること' do
        existing_record = create(:vaccination_record, child: child, vaccine: vaccine1, vaccinated_at: nil)

        update_params = {
          '[vaccination_records]' => {
            '0' => {
              'id' => existing_record.id.to_s,
              'vaccine_id' => vaccine1.id.to_s,
              'vaccinated_at' => '2025-07-02',
              'hospital_name' => '更新病院',
              'memo' => '更新メモ',
              'completed' => 'true'
            }
          }
        }
        expect do
          post create_or_update_child_vaccination_records_path(child), params: update_params
        end.not_to change(VaccinationRecord, :count)
        expect(response).to redirect_to(child_vaccination_records_path(child)) # 正しくリダイレクトされること
        expect(flash[:notice]).to eq '予防接種記録を保存しました。'

        existing_record.reload
        expect(existing_record.vaccinated_at).to eq Date.new(2025, 7, 2)
        expect(existing_record.hospital_name).to eq '更新病院'
      end

      it '日付が空のレコードも保存（更新/作成）できること' do
        existing_record_no_date = create(:vaccination_record, child: child, vaccine: vaccine2, vaccinated_at: nil,
                                                              hospital_name: '空日付の病院')

        params_with_empty_date = {
          '[vaccination_records]' => {
            '0' => {
              'id' => existing_record_no_date.id.to_s,
              'vaccine_id' => vaccine2.id.to_s,
              'vaccinated_at' => '',
              'hospital_name' => '更新空日付の病院',
              'memo' => '更新空日付のメモ',
              'completed' => 'false'
            },
            '1' => {
              'vaccine_id' => vaccine1.id.to_s,
              'vaccinated_at' => '',
              'hospital_name' => '新規空日付の病院',
              'memo' => '新規空日付のメモ',
              'completed' => 'false'
            }
          }
        }

        expect do
          post create_or_update_child_vaccination_records_path(child), params: params_with_empty_date
        end.to change(VaccinationRecord, :count).by(1)

        expect(response).to redirect_to(child_vaccination_records_path(child))

        existing_record_no_date.reload
        expect(existing_record_no_date.vaccinated_at).to be_nil
        expect(existing_record_no_date.hospital_name).to eq '更新空日付の病院'

        created_record_no_date = child.vaccination_records.last
        expect(created_record_no_date.vaccinated_at).to be_nil
        expect(created_record_no_date.hospital_name).to eq '新規空日付の病院'
      end
    end

    context '無効なパラメータの場合' do
      it '必要なパラメータが不足している場合にリダイレクトし、アラートメッセージを表示すること' do
        invalid_params = {
          'some_other_key' => {
            '0' => { 'vaccine_id' => vaccine1.id.to_s }
          }
        }
        expect do
          post create_or_update_child_vaccination_records_path(child), params: invalid_params
        end.not_to change(VaccinationRecord, :count)
        expect(response).to redirect_to(child_vaccination_records_path(child))
        expect(flash[:alert]).to eq '必要な情報が入力されていません。もう一度ご確認ください。'
      end
    end
  end

  describe 'DELETE /children/:child_id/vaccination_records/:id' do
    let!(:record_to_destroy) { create(:vaccination_record, child: child, vaccine: vaccine1) }

    it '予防接種記録を削除し、リダイレクトすること' do
      expect do
        delete child_vaccination_record_path(child, record_to_destroy)
      end.to change(VaccinationRecord, :count).by(-1)
      expect(response).to redirect_to(child_vaccination_records_path(child))
      expect(flash[:notice]).to eq '予防接種記録が削除されました'
    end

    it '存在しない予防接種記録の削除は404を返すこと' do
      expect do
        delete child_vaccination_record_path(child, id: 99_999)
      end.not_to change(VaccinationRecord, :count)
      expect(response).to have_http_status(:not_found)
    end
  end
end
