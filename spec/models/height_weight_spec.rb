require 'rails_helper'

RSpec.describe HeightWeight, type: :model do
  let(:user) {create(:user)}
  let(:child) {create(:child,user: user)}

  describe 'バリデーション' do
    it '身長のみ OK（:height_only）' do
      expect(build(:height_weight, :height_only, child: child)).to be_valid
    end

    it '体重のみ OK（:weight_only）' do
      expect(build(:height_weight, :weight_only, child: child)).to be_valid
    end

    it '身長と体重どちらも空は NG' do
      hw = build(:height_weight, height: nil, weight: nil, child: child)
      expect(hw).to be_invalid
      expect(hw.errors.full_messages).to include("身長か体重のどちらかを入力してください")
    end

    it '身長が負の数は NG（:negative_height）' do
      expect(build(:height_weight, :negative_height, child: child)).to be_invalid
    end

    it '体重が負の数は NG（:negative_weight）' do
      expect(build(:height_weight, :negative_weight, child: child)).to be_invalid
    end

    it 'recorded_on が空は NG' do
      hw = build(:height_weight, recorded_on: nil, child: child)
      expect(hw).to be_invalid
      expect(hw.errors[:recorded_on]).to include("記録日を入力してください")
    end
  end
end
