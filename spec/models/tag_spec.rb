require 'rails_helper'

RSpec.describe Tag, type: :model do
  before do
    @tag = FactoryBot.build(:tag)
  end

  describe 'タグが有効な場合' do
    it 'nameがあれば有効である' do
      expect(@tag).to be_valid
    end
  end

  describe 'タグが無効な場合' do
    it 'nameが空では無効である' do
      @tag.name = ''
      @tag.valid?
      expect(@tag.errors.full_messages).to include("タグ名 を入力してください")
    end

    it 'nameが重複している場合は無効である' do
      FactoryBot.create(:tag, name: "テストタグ")
      @tag.name = "テストタグ"
      @tag.valid?
      expect(@tag.errors.full_messages).to include("タグ名 は既に存在します")
    end
  end
end
