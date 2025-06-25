require 'rails_helper'

RSpec.describe Record, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @child = FactoryBot.create(:child, user: @user)
    @record = FactoryBot.build(:record, child: @child)

    @tag_play = FactoryBot.create(:tag, name: "あそぶ")
    @tag_newborn = FactoryBot.create(:tag, name: "ニューボーン")
    
    @record1 = FactoryBot.create(:record, child: @child, content: "お出かけ", tag_ids: [])
    @record2 = FactoryBot.create(:record, child: @child, content: "赤ちゃん", tags: [@tag_play])
    @record3 = FactoryBot.create(:record, child: @child, content: "新生児", tags: [@tag_newborn])
  end

  let(:child_ids) { [@child.id] }

  context '新規投稿できる' do
    it 'すべての項目が正しく入力されている' do
      @record.content = "テスト"
      @record.images.attach(
        io: File.open(Rails.root.join('spec/fixtures/files/test_image.png')),
        filename: 'test_image.png',
        content_type: 'image/png'
      )
      expect(@record).to be_valid
    end

    it '文章だけあれ場投稿できる' do
      @record.content = "テスト"
      @record.images = nil
      expect(@record).to be_valid
    end

    it '画像だけあれば投稿できる' do
      @record.content = ''
      @record.images.attach(
        io: File.open(Rails.root.join('spec/fixtures/files/test_image.png')),
        filename: 'test_image.png',
        content_type: 'image/png'
      )
      expect(@record).to be_valid
    end
  end

  context '新規投稿できない' do
    it '写真も文章もない場合は保存できない' do
      @record.content = ''
      @record.images = nil
      @record.valid?
      expect(@record.errors.full_messages).to include ("どちらかを記録してみましょう！")
    end

    it '画像のファイルタイプが不正だと保存できない' do
      @record.images.attach(
        io: File.open(Rails.root.join('spec/fixtures/files/invalid_file.txt')),
        filename: 'invalid_file.txt',
        content_type: 'text/plain'
      )
      @record.valid?
      expect(@record.errors.full_messages).to include ("画像 は対応している画像でアップロードしてください")
    end

    it 'child_idがないと保存できない' do
      @record.child = nil
      @record.valid?
      expect(@record.errors.full_messages).to include ("お子さん を登録してください")
    end

    it '文章が長すぎると保存できない' do
      @record.content = 'a' * 501
      @record.valid?
      expect(@record.errors.full_messages).to include ("内容 は500文字以内で入力してください")
    end
  end

  describe '.search' do
    it 'タグ名と内容が空なら結果は空' do
      results = Record.search(child_ids: child_ids, tag_names: '', content: '')
      expect(results).to be_empty
    end

    it 'タグ名で検索できる' do
      results = Record.search(child_ids: child_ids, tag_names: 'あそぶ', content: '')
      expect(results).to include(@record2)
      expect(results).not_to include(@record1, @record3)
    end

    it 'タグ名がスペースやカンマで複数指定できる' do
      results = Record.search(child_ids: child_ids, tag_names: 'あそぶ ニューボーン', content: '')
      expect(results).to include(@record2, @record3)
      expect(results).not_to include(@record1)
    end

    it '内容キーワードで検索できる' do
      results = Record.search(child_ids: child_ids, tag_names: '', content: '出かけ')
      expect(results).to include(@record1)
      expect(results).not_to include(@record2, @record3)
    end

    it 'タグ名と内容の両方で絞り込みできる' do
      results = Record.search(child_ids: child_ids, tag_names: 'あそぶ', content: '赤ちゃん')
      expect(results).to include(@record2)
      expect(results).not_to include(@record1, @record3)
    end
  end
end
