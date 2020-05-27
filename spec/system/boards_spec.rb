require 'rails_helper'

describe '投稿のテスト' do
  let(:user) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:board) { create(:board, user: user) }
  let!(:board2) { create(:board, user: user2) }
  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
  end

  describe 'board新規投稿' do
    context '動作の確認' do
      before do
        visit boards_path
      end
      it 'titleフォームが表示される' do
        expect(page).to have_field 'board[title]'
      end
      it 'contentフォームが表示される' do
        expect(page).to have_field 'board[content]'
      end
      it '投稿に成功する' do
        fill_in 'board[title]', with: Faker::Lorem.characters(number:6)
        fill_in 'board[content]', with: Faker::Lorem.characters(number:20)
        click_button '質問追加'
        expect(page).to have_content '投稿しました'
      end
      it '投稿に失敗する' do
        click_button '質問追加'
        expect(current_path).to eq('/boards')
      end
    end
  end
end