require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end
  describe 'コメント投稿' do
    context 'コメント投稿できる時' do
      it '200文字以内で入力すればコメント投稿できる' do
        expect(@comment).to be_valid
      end
    end
    context 'コメント投稿できない時' do
      it '空入力だとコメント投稿できない' do
        @comment.text = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('コメントを入力してください')
      end
      it '200文字を超えるとコメント投稿できない' do
        @comment.text = Faker::Lorem.characters(number: 201)
        @comment.valid?
        expect(@comment.errors.full_messages).to include('コメントは200文字以内で入力してください')
      end
    end
  end
end
