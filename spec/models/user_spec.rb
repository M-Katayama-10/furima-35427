require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nickname、email、password、password_confirmation、first_name、last_name、first_name_kana、last_name_kana、birthdayが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordとpassword_confirmationが6文字以上であれば登録できる' do
        @user.password = 'e8e8e8'
        @user.password_confirmation = 'e8e8e8'
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it 'last_name_kanaが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'birthdayが空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it '@を含んでいないemailは登録できない' do
        @user.email = 'fdfacsfvsa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '8ffkds'
        @user.password_confirmation = '9gi87h'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '6ah2k'
        @user.password_confirmation = '6ah2k'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordは英語のみでは登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end
      it 'passwordは数字のみでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end
      it 'passwordは全角では登録できない' do
        @user.password = 'ａｉｕｅｏ１'
        @user.password_confirmation = 'ａｉｕｅｏ１'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end
      it 'first_nameが全角でないと登録できない' do
        @user.first_name = 'suzuki'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid. Input full-width characters.')
      end
      it 'last_nameが全角でないと登録できない' do
        @user.last_name = 'jirou'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid. Input full-width characters.')
      end
      it 'first_name_kanaが全角カナでないと登録できない' do
        @user.first_name_kana = 'すずき'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid. Input full-width katakana characters.')
      end
      it 'last_nameが_kanaが全角カナでないと登録できない' do
        @user.last_name_kana = 'じろう'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid. Input full-width katakana characters.')
      end
    end
  end
end
