require 'rails_helper'

RSpec.describe 'salonモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:user) { create(:user) }
    let!(:salon) { build(:salon, user_id: user.id) }

    context 'salon_nameカラム' do
      it '空欄でないこと' do
        salon.salon_name = ''
        expect(salon.valid?).to eq false;
      end
      it '2文字以上であること' do
        salon.salon_name = Faker::Lorem.characters(number:1)
        expect(salon.valid?).to eq false;
      end
      it '20文字以下であること' do
        salon.salon_name = Faker::Lorem.characters(number:21)
        expect(salon.valid?).to eq false;
      end
    end

    context 'salon_addressカラム' do
      it '空欄でないこと' do
        salon.salon_address = ''
        expect(salon.valid?).to eq false;
      end
      it '40文字以下であること' do
        salon.salon_address = Faker::Lorem.characters(number:41)
        expect(salon.valid?).to eq false;
      end
    end

    context 'salon_phoneカラム' do
      it '空欄でないこと' do
        salon.salon_phone = ''
        expect(salon.valid?).to eq false;
      end
      it '2文字以上であること' do
        salon.salon_phone = Faker::Number.number(digits: 1)
        expect(salon.valid?).to eq false;
      end
      it '12文字以下であること' do
        salon.salon_phone = Faker::Number.number(digits: 13)
        expect(salon.valid?).to eq false;
      end
    end

  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Salon.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end