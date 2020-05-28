describe '管理者のテスト' do
  describe '管理者USER画面のテスト' do
  let(:admin) { create(:admin) }
  before do
    visit new_admin_session_path
    fill_in 'admin[email]', with: admin.email
    fill_in 'admin[password]', with: admin.password
    click_button 'Log in'
  end
    context '表示の確認' do
      it '検索ボタンが表示される' do
        visit admins_users_path
        click_button '検索'
      end
    end
  end
end