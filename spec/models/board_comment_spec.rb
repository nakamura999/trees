require 'rails_helper'

RSpec.describe 'board_commentモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:user) { create(:user) }
    let!(:board) { build(:board, user_id: user.id) }
    let!(:board_comment) { build(:board_comment, user_id: user.id) }

    context 'commentカラム' do
      it '空欄でないこと' do
        board_comment.comment = ''
        expect(board_comment.valid?).to eq false;
      end
      it '2文字以上であること' do
        board_comment.comment = Faker::Lorem.characters(number:1)
        expect(board_comment.valid?).to eq false;
      end
      it '200文字以下であること' do
        board_comment.comment = Faker::Lorem.characters(number:201)
        expect(board_comment.valid?).to eq false;
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(BoardComment.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Boardモデルとの関係' do
      it 'N:1となっている' do
        expect(BoardComment.reflect_on_association(:board).macro).to eq :belongs_to
      end
    end
  end
end