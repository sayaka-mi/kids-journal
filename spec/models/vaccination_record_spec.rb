require 'rails_helper'

RSpec.describe VaccinationRecord, type: :model do

  let!(:child) { FactoryBot.create(:child) }
  let!(:vaccine) { FactoryBot.create(:vaccine) }

  describe 'associations' do
    it {is_expected.to belong_to(:child)}
    it {is_expected.to belong_to(:vaccine).optional}
  end

  describe 'vaccinations' do
    describe 'vaccine_idかother_vaccine_nameの存在' do
      it 'ワクチンIDとその他のワクチン名の両方が存在しない場合は無効' do
        record = build(:vaccination_record, child: child, vaccine: nil, vaccine_id: nil, other_vaccine_name: nil)
        expect(record).to be_invalid
        expect(record.errors[:base]).to include("ワクチン名またはその他のワクチン名を入力してください")
      end

      it 'ワクチンIDが存在する場合は有効であること' do
        record = build(:vaccination_record, child: child, vaccine: vaccine, other_vaccine_name: nil)
        expect(record).to be_valid
      end

      it 'その他のワクチン名が存在する場合は有効であること' do
        record = build(:vaccination_record, child: child, vaccine: nil, vaccine_id: nil, other_vaccine_name: '新しいワクチン')
        expect(record).to be_valid
      end
    end

    describe '#vaccinated_at_required_if_completed' do
      it 'completedがtrueでvaccinated_atが空の場合は無効であること' do
        record = build(:vaccination_record, child: child, vaccine: vaccine, completed: true, vaccinated_at: nil)
        expect(record).to be_invalid
        expect(record.errors[:vaccinated_at]).to include("接種日を入力してください（接種済みの場合）")
      end

      it 'completedがtrueでvaccinated_atが存在する場合は有効であること' do
        record = build(:vaccination_record, child: child, vaccine: vaccine, completed: true, vaccinated_at: Date.today)
        expect(record).to be_valid
      end

      it 'completedがfalseでvaccinated_atが空の場合は有効であること' do
        record = build(:vaccination_record, child: child, vaccine: vaccine, completed: false, vaccinated_at: nil)
        expect(record).to be_valid
      end
    end

    it { is_expected.to validate_numericality_of(:vaccine_id).only_integer.allow_nil }
  end

  describe 'callbacks' do
    describe '#set_completed' do
      it 'vaccinated_atが存在する場合、completedがtrueに設定されること' do
        record = build(:vaccination_record, child: child, vaccine: vaccine, vaccinated_at: Date.today, completed: false)
        record.save
        expect(record.completed).to be true
      end

      it 'vaccinated_atがnilの場合、completedがfalseに設定されること' do
        record = build(:vaccination_record, child: child, vaccine: vaccine, vaccinated_at: nil)
        record.save
        expect(record.completed).to be false
      end
    end
  end

  describe '#vaccine_name' do
    it 'vaccineが存在する場合、その名前を返すこと' do
      record = build(:vaccination_record, child: child, vaccine: vaccine, other_vaccine_name: nil)
      expect(record.vaccine_name).to eq vaccine.name
    end

    it 'other_vaccine_nameが存在し、vaccineがnilの場合、other_vaccine_nameを返すこと' do
      record = build(:vaccination_record, child: child, vaccine: nil, vaccine_id: nil, other_vaccine_name: 'カスタムワクチン')
      expect(record.vaccine_name).to eq 'カスタムワクチン'
    end

    it '両方nilの場合、nilを返すこと' do
      record = build(:vaccination_record, child: child, vaccine: nil, vaccine_id: nil, other_vaccine_name: nil)
      expect(record.vaccine_name).to be_nil
    end
  end

  describe 'scopes' do
    let!(:completed_record) { create(:vaccination_record, child: child, vaccine: vaccine, vaccinated_at: Date.today, completed: true) }
    let!(:scheduled_record) { create(:vaccination_record, child: child, vaccine: vaccine, vaccinated_at: nil, completed: false) }

    describe '.completed' do
      it 'completedがtrueのレコードを返すこと' do
        expect(VaccinationRecord.completed).to include(completed_record)
        expect(VaccinationRecord.completed).not_to include(scheduled_record)
      end
    end

    describe '.scheduled' do
      it 'completedがfalseのレコードを返すこと' do
        expect(VaccinationRecord.scheduled).to include(scheduled_record)
        expect(VaccinationRecord.scheduled).not_to include(completed_record)
      end
    end
  end
end
