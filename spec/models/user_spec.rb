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
    end
  end
end
