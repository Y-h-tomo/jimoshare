require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザー情報の登録' do
    context 'ユーザー情報の登録ができるとき' do
      it 'データが全て正しく入力されているとき、ユーザー登録ができる' do
        expect(@user).to be_valid
      end
      it '問い合わせemailが未入力でもユーザー登録ができる' do
        @user.contact_email = nil
        expect(@user).to be_valid
      end
      it '緊急出品用引き渡し場所が未入力でもユーザー登録ができる' do
        @user.contact_location = nil
        expect(@user).to be_valid
      end
    end
  end
  context 'ユーザー情報の登録ができないとき' do
    it '名前が未入力だとユーザー登録ができない' do
      @user.nickname = nil
      @user.valid?
      expect(@user.errors.full_messages).to include('ニックネームを入力してください')
    end
    it '登録用Eメールが未入力だとユーザー登録ができない' do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include('Eメールを入力してください')
    end
    it '登録用Eメールが重複するとユーザー登録できない' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
    end
    it '登録用Eメールが@を含まないとユーザー登録できない' do
      @user.email = 'abcdefg.com'
      @user.valid?
      expect(@user.errors.full_messages).to include('Eメールは不正な値です')
    end
    it 'パスワードが空だとユーザー登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードを入力してください')
    end
    it 'パスワードが6文字未満だとユーザー登録できない' do
      @user.password = '1a2b3'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
    end
    it 'パスワードは英数字ふくまないとユーザー登録できない' do
      @user.password = '123456'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードは不正な値です')
    end
    it 'パスワード、パスワード確認用、両方入力しないとユーザー登録できない' do
      @user.password = '1a2b3c'
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
    end
    it 'パスワード、パスワード確認用が一致しないとユーザー登録できない' do
      @user.password = '1a2b3c'
      @user.password_confirmation = '1a2b3c4'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
    end
    it '電話番号が未入力だとユーザー登録ができない' do
      @user.phone_number = nil
      @user.valid?
      expect(@user.errors.full_messages).to include('電話番号を入力してください')
    end
    it '電話番号が12桁以上だとユーザー登録できない' do
      @user.phone_number = "0#{rand(0..9)}0#{rand(100_000_000..999_999_999)}"
      @user.valid?
      expect(@user.errors.full_messages).to include('電話番号は不正な値です')
    end
    it '電話番号が9桁以下だとユーザー登録できない' do
      @user.phone_number = "0#{rand(0..9)}0#{rand(100_000..999_999)}"
      @user.valid?
      expect(@user.errors.full_messages).to include('電話番号は不正な値です')
    end
    it '電話番号の最初が0[0~9]0になっていないとユーザー登録できない' do
      @user.phone_number = "1#{rand(0..9)}2#{rand(1_000_000..99_999_999)}"
      @user.valid?
      expect(@user.errors.full_messages).to include('電話番号は不正な値です')
    end
    it '電話番号にハイフンが入っているとユーザー登録できない' do
      @user.phone_number = "0#{rand(0..9)}0-#{rand(1_000_000..99_999_999)}"
      @user.valid?
      expect(@user.errors.full_messages).to include('電話番号は不正な値です')
    end
  end
end
