require 'rails_helper'

RSpec.describe 'boardモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:user) { create(:user) }
    let!(:board) { build(:board, user_id: user.id) }

    context 'titleカラム' do
      it '空欄でないこと' do
        board.title = ''
        expect(board.valid?).to eq false;
      end
      it '2文字以上であること' do
        board.title = Faker::Lorem.characters(number:1)
        expect(board.valid?).to eq false;
      end
      it '30文字以下であること' do
        board.title = Faker::Lorem.characters(number:31)
        expect(board.valid?).to eq false;
      end
    end

    context 'contentカラム' do
      it '空欄でないこと' do
        board.content = ''
        expect(board.valid?).to eq false;
      end
      it '200文字以下であること' do
        board.content = Faker::Lorem.characters(number:201)
        expect(board.valid?).to eq false;
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Board.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end