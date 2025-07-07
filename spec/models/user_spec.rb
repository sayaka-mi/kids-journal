require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'ユーザー新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end

    context '登録できる場合' do
      it '全ての項目が正しく入力されていれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '登録できない場合' do
      it 'nameが空では登録できないこと' do
        @user.name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include ("あなたのお名前 を教えてください！")
      end

      it 'name がnilの場合は登録できないこと' do
        @user.name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include ("あなたのお名前 を教えてください！")
      end

      it 'email が空では登録できないこと' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include ("メールアドレス を入力してください！")
      end

      it 'email がnilの場合は登録できないこと' do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include ("メールアドレス を入力してください！")
      end

      it '重複した email は登録できないこと (大文字小文字を区別しない)' do
        FactoryBot.create(:user, email: "unique@example.com")
        @user.email = "UNIQUE@example.com"
        @user.valid?
        expect(@user.errors.full_messages).to include ("メールアドレス は既に使用されています。別のメールアドレスをお試しください！")
      end

      it '無効な email フォーマットの場合は登録できないこと' do
        invalid_emails = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
        invalid_emails.each do |email|
          @user.email = email
          @user.valid?
          expect(@user.errors.full_messages).to include ("メールアドレス の形式が正しくありません！")
        end
      end

      it 'password が空では登録できないこと' do
        @user.password = ''
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include ("パスワード を入力してください！")
      end

      it 'password が6文字未満の場合は登録できないこと' do
        @user.password = @user.password_confirmation = '123aa'
        @user.valid?
        expect(@user.errors.full_messages).to include ("パスワード は6文字以上で入力してください。")
      end

      it 'password が半角英数字混合でない場合は登録できないこと (数字のみ)' do
        @user.password = @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include ("パスワード は半角英数字をそれぞれ1文字以上含めて入力してください！")
      end

      it 'password が半角英数字混合でない場合は登録できないこと (英字のみ)' do
        @user.password = @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include ("パスワード は半角英数字をそれぞれ1文字以上含めて入力してください！")
      end

      it 'password と password_confirmation が一致しない場合は登録できないこと' do
        @user.password = '123abc'
        @user.password_confirmation = 'abc123'
        @user.valid?
        expect(@user.errors.full_messages).to include ("確認用パスワード とパスワード（確認用）が一致しません！")
      end
    end
  end
end
