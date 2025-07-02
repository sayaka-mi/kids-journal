require 'rails_helper'

RSpec.describe Vaccine, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:vaccination_records) }

    it 'ワクチンが削除されたとき、関連する予防接種記録のvaccine_idがnilになること' do
      vaccine = FactoryBot.create(:vaccine)
      child = FactoryBot.create(:child)
      vaccination_record = FactoryBot.create(:vaccination_record, vaccine: vaccine, child: child)
      vaccine.destroy
      vaccination_record.reload
      expect(vaccination_record.vaccine_id).to be_nil
    end
  end
end
