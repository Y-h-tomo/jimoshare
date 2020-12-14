require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  describe '商品の登録' do
    context '商品が出品できる時' do
      it '全ての情報が正しく入力されていたら、商品が出品できる' do
        expect(@item).to be_valid
      end
      it '全ての情報が正しく入力されており、商品名が40文字以内なら出品できる' do
        @item.name = Faker::Lorem.characters(number: 40)
        expect(@item).to be_valid
      end
      it '全ての情報が正しく入力されており、商品説明・条件が200文字以内なら出品できる' do
        @item.description = Faker::Lorem.characters(number: 200)
        expect(@item).to be_valid
      end
      it '全ての情報が正しく入力されており,個数が99個でも出品できる' do
        @item.quantity = 99
        expect(@item).to be_valid
      end
      it '全ての情報が正しく入力されており,価格が0円でも出品できる' do
        @item.price = 0
        expect(@item).to be_valid
      end
      it '全ての情報が正しく入力されており,価格が999_999円でも出品できる' do
        @item.price = 999_999
        expect(@item).to be_valid
      end
    end
  end
end
