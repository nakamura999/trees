require 'rails_helper'

RSpec.describe 'styleモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:user) { create(:user) }
    let!(:style) { build(:style, user_id: user.id) }

    context 'nameカラム' do
      it '空欄でないこと' do
        style.name = ''
        expect(style.valid?).to eq false;
      end
      it '2文字以上であること' do
        style.name = Faker::Lorem.characters(number:1)
        expect(style.valid?).to eq false;
      end
      it '20文字以下であること' do
        style.name = Faker::Lorem.characters(number:21)
        expect(style.valid?).to eq false;
      end
    end

    context 'contentカラム' do
      it '空欄でないこと' do
        style.content = ''
        expect(style.valid?).to eq false;
      end
      it '100文字以下であること' do
        style.content = Faker::Lorem.characters(number:101)
        expect(style.valid?).to eq false;
      end
    end

    context 'priceカラム' do
      it '10文字以下であること' do
        style.price = Faker::Number.number(digits: 11)
        expect(style.valid?).to eq false;
      end
    end

    context 'color_styleカラム' do
      it '空欄でないこと' do
        style.color_style = ''
        expect(style.valid?).to eq false;
      end
      it '20文字以下であること' do
        style.color_style = Faker::Lorem.characters(number:21)
        expect(style.valid?).to eq false;
      end
    end

    context 'menuカラム' do
      it '空欄でないこと' do
        style.menu = ''
        expect(style.valid?).to eq false;
      end
      it '2文字以上であること' do
        style.menu = Faker::Lorem.characters(number:1)
        expect(style.valid?).to eq false;
      end
      it '20文字以下であること' do
        style.menu = Faker::Lorem.characters(number:26)
        expect(style.valid?).to eq false;
      end
    end

  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Style.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end