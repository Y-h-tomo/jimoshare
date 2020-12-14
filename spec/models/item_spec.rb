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
      it ''
    end
  end
end
