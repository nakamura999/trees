require 'rails_helper'

describe '投稿のテスト' do
  let(:user) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:board) { create(:board, user: user) }
  let!(:board2) { create(:board, user: user2) }
  let!(:board_comment) { create(:board_comment, user: user, board: board) }
  let!(:board_comment2) { create(:board_comment, user: user2, board: board2) }
  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
  end

  describe '掲示板コメント新規投稿' do
    context '動作の確認' do
      before do
        visit board_path(board)
      end
      it 'commentフォームが表示される' do
        expect(page).to have_field 'board_comment[comment]'
      end
      it '投稿に成功する' do
        fill_in 'board_comment[comment]', with: Faker::Lorem.characters(number:30)
        click_button 'コメント'
        expect(page).to have_content 'コメントしました'
      end
      it '投稿に失敗する' do
        click_button 'コメント'
        expect(page).to have_content 'コメントは1文字以上200文字以内です'
      end
    end
  end
end