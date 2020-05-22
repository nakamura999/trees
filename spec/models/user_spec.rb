require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  # 名前が空欄で登録できない→名前を空欄で登録したらfalse
  # バリデーションしていない状態で失敗→設定したら成功
  # 登録できるかできないか 登録できたら失敗
  # エラーメッセージがなければ失敗

  describe 'バリデーションのテスト' do
    let(:user) { build(:user) }
    subject { test_user.valid? }

    # 名前
    context 'nameカラム' do
      let(:test_user) { user }
      it '空欄でないこと' do
        test_user.name = ''
        is_expected.to eq false;
      end
      it '2文字以上であること' do
        test_user.name = Faker::Lorem.characters(number:1)
        is_expected.to eq false;
      end
      it '20文字以下であること' do
        test_user.name = Faker::Lorem.characters(number:21)
        is_expected.to eq false;
      end
    end
    
    # ニックネーム
    context 'nicknameカラム' do
      let(:test_user) { user }
      it '空欄でないこと' do
        test_user.nickname = ''
        is_expected.to eq false;
      end
      it '2文字以上であること' do
        test_user.nickname = Faker::Lorem.characters(number:1)
        is_expected.to eq false;
      end
      it '20文字以下であること' do
        test_user.nickname = Faker::Lorem.characters(number:21)
        is_expected.to eq false;
      end
    end

    # フリガナ
    context 'kana_nameカラム' do
      let(:test_user) { user }
      it '空欄でないこと' do
        test_user.kana_name = ''
        is_expected.to eq false;
      end
      it '2文字以上であること' do
        test_user.kana_name = Faker::Lorem.characters(number:1)
        is_expected.to eq false;
      end
      it '20文字以下であること' do
        test_user.kana_name = Faker::Lorem.characters(number:21)
        is_expected.to eq false;
      end
    end

    # 都道府県
    context 'prefectureカラム' do
      let(:test_user) { user }
      it '空欄でないこと' do
        test_user.prefecture = ''
        is_expected.to eq false;
      end
      it '2文字以上であること' do
        test_user.prefecture = Faker::Lorem.characters(number:1)
        is_expected.to eq false;
      end
      it '5文字以下であること' do
        test_user.prefecture = Faker::Lorem.characters(number:6)
        is_expected.to eq false;
      end
    end

    # PR分
    context 'bodyカラム' do
      let(:test_user) { user }
      it '100文字以下であること' do
        test_user.body = Faker::Lorem.characters(number:101)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'styleモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:styles).macro).to eq :has_many
      end
    end
  end
end
# アソシエーションのテスト