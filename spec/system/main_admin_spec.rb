require 'rails_helper'

describe '管理者権限のテスト'  do
  let!(:admin) { create(:admin) }
  let!(:user) { create(:user) }
  let!(:jenre) { create(:jenre) }
  describe 'ログインしていない場合' do
    context '管理者top関連のURLにアクセス' do
      it '管理者top画面に遷移できない' do
        visit admins_top_admin_index_path
        expect(current_path).to eq('/admins/sign_in')
      end
    end
  end
  describe 'ログインしていない場合にユーザー関連のURLにアクセス' do
    context 'ユーザー関連のURLにアクセス' do
      it '会員一覧画面に遷移できない' do
        visit admins_users_path
        expect(current_path).to eq('/admins/sign_in')
      end
      it '会員詳細画面に遷移でない' do
        visit admins_user_path(user.id)
        expect(current_path).to eq('/admins/sign_in')
      end
    end
  end
  describe 'ログインしていない場合にジャンル関連のURLにアクセス' do
    context 'ジャンル関連のURLにアクセス' do
      it 'ジャンル一覧画面に遷移できない' do
        visit admins_jenres_path
        expect(current_path).to eq('/admins/sign_in')
      end
      it 'ジャンル編集画面に遷移でない' do
        visit edit_admins_jenre_path(jenre.id)
        expect(current_path).to eq('/admins/sign_in')
      end
    end
  end
end