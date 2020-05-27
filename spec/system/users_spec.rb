require 'rails_helper'

describe 'ユーザー認証のテスト' do
  describe 'ユーザー新規登録' do
    before do
      visit new_user_registration_path
    end
    context '新規登録画面に遷移' do
      it '新規登録に成功する' do
        fill_in 'user[name]', with: Faker::Lorem.characters(number:10)
        fill_in 'user[kana_name]', with: Faker::Lorem.characters(number:10)
        fill_in 'user[nickname]', with: Faker::Lorem.characters(number:10)
        fill_in 'user[prefectures]', with: Faker::Lorem.characters(number:4)
        fill_in 'user[body]', with: Faker::Lorem.characters(number:20)
        fill_in 'user[status]', with: "MENS"
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_button 'Sign up'

        expect(current_path).to eq(styles_path)
      end
      it '新規登録に失敗する' do
        fill_in 'user[name]', with: ''
        fill_in 'user[kana_name]', with: ''
        fill_in 'user[nickname]', with: ''
        fill_in 'user[prefectures]', with: ''
        fill_in 'user[body]', with: ''
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        fill_in 'user[password_confirmation]', with: ''
        click_button 'Sign up'

        expect(current_path).to eq(new_user_registration_path)
      end
    end
  end
  describe 'ユーザーログイン' do
    let(:user) { create(:user) }
    before do
      visit new_user_session_path
    end
    context 'ログイン画面に遷移' do
      let(:test_user) { user }
      it 'ログインに成功する' do
        fill_in 'user[email]', with: test_user.email
        fill_in 'user[password]', with: test_user.password
        click_button 'Log in'

        expect(current_path).to eq(styles_path)
      end

      it 'ログインに失敗する' do
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        click_button 'Log in'

        expect(current_path).to eq(new_user_session_path)
      end
    end
  end
end

describe 'ユーザーのテスト' do
  let(:user) { create(:user) }
  let!(:test_user2) { create(:user) }
  let!(:style) { create(:style, user: user) }
  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
  end

  describe '編集のテスト' do
    context '自分の編集画面への遷移' do
      it '遷移できる' do
        visit edit_user_path(user)
        expect(current_path).to eq('/users/' + user.id.to_s + '/edit')
      end
    end
    context '他人の編集画面への遷移' do
      it '遷移できない' do
        visit edit_user_path(test_user2)
        expect(current_path).to eq('/users/' + user.id.to_s)
      end
    end

    context '表示の確認' do
      before do
        visit edit_user_path(user)
      end
      it '画像編集フォームが表示される' do
        expect(page).to have_field 'user[profile_image]'
      end
      it '名前編集フォームに自分の名前が表示される' do
        expect(page).to have_field 'user[name]', with: user.name
      end
      it 'フリガナ編集フォームに自分のフリガナが表示される' do
        expect(page).to have_field 'user[kana_name]', with: user.kana_name
      end
      it 'ニックネーム編集フォームに自分のニックネームが表示される' do
        expect(page).to have_field 'user[nickname]', with: user.nickname
      end
      it '都道府県編集フォームに自分の都道府県が表示される' do
        expect(page).to have_field 'user[prefectures]', with: user.prefectures
      end
      it '情編集フォームに自分の情報が表示される' do
        expect(page).to have_field 'user[status]', with: user.status
      end
      it '自己PR編集フォームに自分の自己PRが表示される' do
        expect(page).to have_field 'user[body]', with: user.body
      end
      it 'メール編集フォームに自分のメールアドレスが表示される' do
        expect(page).to have_field 'user[email]', with: user.email
      end
      it 'パスワード編集リンクが表示される' do
        expect(page).to have_link 'パスワード変更', href: passwords_path(user)
        expect(page).to have_link 'パスワード変更', href: passwords_path(test_user2)
      end
      it '退会ページリンクが表示される' do
        expect(page).to have_link '退会する', href: withdraw_path(user)
        expect(page).to have_link '退会する', href: withdraw_path(test_user2)
      end
      it '編集に成功する' do
        click_button '変更を保存'
        expect(page).to have_content '会員情報を変更'
        expect(current_path).to eq('/users/' + user.id.to_s)
      end
      it '編集に失敗する' do
        fill_in 'user[name]', with: ''
        click_button '変更を保存'
        expect(current_path).to eq('/users/' + user.id.to_s)
      end
    end
  end

  describe 'USER詳細画面のテスト' do
    before do
      visit user_path(user)
    end
    context '表示の確認' do
      it 'style一覧のユーザーの画像のリンク先が正しい' do
        expect(page).to have_link '', href: style_path(style)
      end
      it 'マイページにnicknameが表示される' do
        expect(page).to have_content(user.nickname)
      end
      it 'マイページにstatusが表示される' do
        expect(page).to have_content(user.status)
      end
      it 'マイページにbodyが表示される' do
        expect(page).to have_content(user.body)
      end
      it 'マイページ編集リンクが表示される' do
        expect(page).to have_link 'マイページ編集', href: edit_user_path(user)
        expect(page).to have_link 'マイページ編集', href: edit_user_path(test_user2)
      end
      it 'SALON新規登録リンクが表示される' do
        expect(page).to have_link 'Salon新規登録', href: new_salon_path
      end
      it 'Style新規登録リンクが表示される' do
        expect(page).to have_link 'Style新規登録', href: new_style_path
      end
    end
  end
end
