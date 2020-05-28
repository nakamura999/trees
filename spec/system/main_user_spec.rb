require 'rails_helper'

describe 'ユーザー権限のテスト'  do
  let!(:user) { create(:user) }
  let!(:style) { create(:style, user: user) }
  let!(:board) { create(:board, user: user) }
  describe 'ログインしていない場合' do
    context 'Style関連のURLにアクセス' do
      it 'style編集画面に遷移できない' do
        visit edit_style_path(style.id)
        expect(current_path).to eq('/users/sign_in')
      end
      it 'style新規登録画面に遷移できない' do
        visit new_style_path
        expect(current_path).to eq('/users/sign_in')
      end
    end
  end
  describe 'ログインしていない場合にユーザー関連のURLにアクセス' do
    context 'ユーザー関連のURLにアクセス' do
      it 'マイページ編集画面に遷移できない' do
        visit edit_user_path(user.id)
        expect(current_path).to eq('/users/sign_in')
      end
      it 'マイページに遷移でない' do
        visit user_path(user.id)
        expect(current_path).to eq('/users/sign_in')
      end
    end
  end
  describe 'ログインしていない場合に掲示板関連のURLにアクセス' do
    context '掲示板関連のURLにアクセス' do
      it '掲示板一覧画面に遷移できない' do
        visit boards_path
        expect(current_path).to eq('/users/sign_in')
      end
      it '掲示板詳細画面に遷移でない' do
        visit board_path(board.id)
        expect(current_path).to eq('/users/sign_in')
      end
    end
  end
end