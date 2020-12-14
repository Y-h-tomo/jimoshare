require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  describe '商品の出品' do
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

    context '商品の出品ができない時' do
      it '商品名が空白だと出品できない' do
        @item.name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it '商品名が40文字を超えていると出品できない' do
        @item.name = Faker::Lorem.characters(number: 41)
        @item.valid?
        expect(@item.errors.full_messages).to include('Name is too long (maximum is 40 characters)')
      end
      it '画像がないと出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品説明・条件がないと出品できない' do
        @item.description = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it '商品説明・条件が200文字を超えていると出品できない' do
        @item.description = Faker::Lorem.characters(number: 201)
        @item.valid?
        expect(@item.errors.full_messages).to include('Description is too long (maximum is 200 characters)')
      end
      it '価格が未入力だと出品できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it '価格が1_000_000円以上だと出品できない' do
        @item.price = 1_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than 1000000')
      end
      it '個数が未入力だと出品できない' do
        @item.quantity = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Quantity can't be blank")
      end
      it '個数が100個以上だと出品できない' do
        @item.quantity = 100
        @item.valid?
        expect(@item.errors.full_messages).to include('Quantity must be less than 100')
      end
      it '引き渡し期限日が未入力だと出品できない' do
        @item.deadline = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Deadline can't be blank")
      end
      it '引き渡し期限日が現在より過去だと出品できない' do
        @item.deadline = Faker::Date.between_except(from: 1.year.ago, to: Date.today, excepted: Date.today)
        @item.valid?
        expect(@item.errors.full_messages).to include('Deadline は今日以降のものを選択してください')
      end
      it '分類選択をしていないと出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Category must be other than 1')
      end
      it 'エリアについてのの選択をしていないと商品登録できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture must be other than 1')
      end
      it '商品の状態についての選択をしていないと商品登録できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Condition must be other than 1')
      end
      it '引き渡し場所の入力をしていないと商品登録できない' do
        @item.contact_location = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Contact location can't be blank")
      end
    end
  end
end
