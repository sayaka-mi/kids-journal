require 'rails_helper'

RSpec.describe Child, type: :model do
  describe '新規登録' do
    before do
      user = FactoryBot.create(:user)
      @child = FactoryBot.build(:child, user: user)
    end

    context '登録できる場合' do
      it '全ての項目が正しく入力されていれば登録できる' do
        expect(@child).to be_valid
      end
    end

    context '登録できない場合' do
      it 'name が空では登録できないこと' do
        @child.name = ''
        @child.valid?
        expect(@child.errors.full_messages).to include('お子さんの名前 を教えてください！')
      end

      it 'name がnilの場合は登録できないこと' do
        @child.name = nil
        @child.valid?
        expect(@child.errors.full_messages).to include('お子さんの名前 を教えてください！')
      end

      it 'birthday が空では登録できないこと' do
        @child.birthday = ''
        @child.valid?
        expect(@child.errors.full_messages).to include('生年月日 を教えてください！')
      end

      it 'birthday がnilの場合は登録できないこと' do
        @child.birthday = nil
        @child.valid?
        expect(@child.errors.full_messages).to include('生年月日 を教えてください！')
      end

      it 'gender が空では登録できないこと' do
        @child.gender = ''
        @child.valid?
        expect(@child.errors.full_messages).to include('性別 を選んでください！')
      end

      it 'gender がnilの場合は登録できないこと' do
        @child.gender = nil
        @child.valid?
        expect(@child.errors.full_messages).to include('性別 を選んでください！')
      end

      it 'blood_type が空では登録できないこと' do
        @child.blood_type = ''
        @child.valid?
        expect(@child.errors.full_messages).to include('血液型 を選んでください！')
      end

      it 'blood_type がnilの場合は登録できないこと' do
        @child.blood_type = nil
        @child.valid?
        expect(@child.errors.full_messages).to include('血液型 を選んでください！')
      end

      it 'user がnilの場合は登録できないこと' do
        @child.user = nil
        @child.valid?
        expect(@child.errors.full_messages).to include('保護者 を登録してください')
      end
    end
  end

  describe '#age_in_years_and_months' do
    it '正しく年齢と月齢を返す' do
      child = FactoryBot.build(:child, birthday: Date.new(2020, 11, 9))

      travel_to Date.new(2025, 6, 17) do
        expect(child.age_in_years_and_months).to eq '4歳7か月'
      end
    end

    it 'birthdayがない場合はnilを返す' do
      child = FactoryBot.build(:child, birthday: nil)
      expect(child.age_in_years_and_months).to eq nil
    end
  end
end
