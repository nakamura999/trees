describe '管理者のテスト' do
  describe '管理者ログイン' do
    let(:admin) { create(:admin) }
    before do
      visit new_admin_session_path
    end
    context 'ログイン画面に遷移' do
      let(:test_admin) { admin }
      it 'ログインに成功する' do
        fill_in 'admin[email]', with: test_admin.email
        fill_in 'admin[password]', with: test_admin.password
        click_button 'Log in'

        expect(current_path).to eq(admins_top_admin_index_path)
      end

      it 'ログインに失敗する' do
        fill_in 'admin[email]', with: ''
        fill_in 'admin[password]', with: ''
        click_button 'Log in'

        expect(current_path).to eq(new_admin_session_path)
      end
    end
  end
  describe '管理者TOP画面のテスト' do
  let(:admin) { create(:admin) }
  before do
    visit new_admin_session_path
    fill_in 'admin[email]', with: admin.email
    fill_in 'admin[password]', with: admin.password
    click_button 'Log in'
  end
    context '表示の確認' do
      it '会員一覧リンクが表示される' do
      	visit admins_top_admin_index_path
        expect(page).to have_link '会員一覧', href: admins_users_path
      end
      it 'ジャンル一覧リンクが表示される' do
      	visit admins_top_admin_index_path
        expect(page).to have_link 'ジャンル', href: admins_jenres_path
      end
    end
  end
end