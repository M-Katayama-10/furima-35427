require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  describe '商品購入機能' do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.create(:item)
      @purchase_address = FactoryBot.build(:purchase_address, user_id: @user.id, item_id: @item.id)
      sleep 0.1
    end

    context '購入できるとき' do
      it 'postal_code、area_id、municipality、house_number、phone_number、tokenが存在すれば購入できる' do
        expect(@purchase_address).to be_valid
      end
      it 'buildingが空でも購入できる' do
        @purchase_address.building = ''
        expect(@purchase_address).to be_valid
      end
    end
    context '購入できないとき' do
      it 'postal_codeが空では購入できない' do
        @purchase_address.postal_code = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postal code can't be blank", "Postal code is invalid")
      end
      it 'area_idが空では購入できない' do
        @purchase_address.area_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Area is not a number")
      end
      it 'municipalityが空では購入できない' do
        @purchase_address.municipality = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Municipality can't be blank")
      end
      it 'house_numberが空では購入できない' do
        @purchase_address.house_number = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("House number can't be blank")
      end
      it 'phone_numberが空では購入できない' do
        @purchase_address.phone_number = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number can't be blank", "Phone number is invalid")
      end
      it 'area_idがid:1では購入できない' do
        @purchase_address.area_id = 1
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Area must be other than 1')
      end
      it 'postal_codeが全角を含むと購入できない' do
        @purchase_address.postal_code = '７８９-5433'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postal code is invalid")
      end
      it 'postal_codeが英語ではでは購入できない' do
        @purchase_address.postal_code = 'abc-defg'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postal code is invalid")
      end
      it 'postal_codeが半角ハイフンを含まないと購入できない' do
        @purchase_address.postal_code = '4763309'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postal code is invalid")
      end
      it 'postal_codeが英数混合では購入できない' do
        @purchase_address.postal_code = 'abc-1234'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postal code is invalid")
      end
      it 'phone_numberが全角を含むと購入できない' do
        @purchase_address.phone_number = '080７７７７4444'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number is invalid")
      end
      it 'phone_numberが英語では購入できない' do
        @purchase_address.phone_number = 'aaakkkktttt'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number is invalid")
      end
      it 'phone_numberが英数混合では購入できない' do
        @purchase_address.phone_number = 'ddd2345gggg'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number is invalid")
      end
      it 'phone_numberが12桁以上では購入できない' do
        @purchase_address.phone_number = '090111122223'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number is too long (maximum is 11 characters)")
      end
      it 'userが紐付いていないと購入できない' do
        @purchase_address.user_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていないと購入できない' do
        @purchase_address.item_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Item can't be blank")
      end
      it 'tokenが空では購入できない' do
        @purchase_address.token = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end

