require 'rails_helper'

RSpec.describe 'salonモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:jenre) { create(:jenre) }

    context 'nameカラム' do
      it '空欄でないこと' do
        jenre.name = ''
        expect(jenre.valid?).to eq false;
      end
      it '2文字以上であること' do
        jenre.name = Faker::Lorem.characters(number:1)
        expect(jenre.valid?).to eq false;
      end
      it '20文字以下であること' do
        jenre.name = Faker::Lorem.characters(number:21)
        expect(jenre.valid?).to eq false;
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'styleモデルとの関係' do
      it '1:Nとなっている' do
        expect(Jenre.reflect_on_association(:styles).macro).to eq :has_many
      end
    end
  end
end