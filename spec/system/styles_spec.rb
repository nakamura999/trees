require 'rails_helper'

describe '投稿のテスト' do
  let(:user) { create(:user) }
  let!(:user2) { create(:user) }
  let(:jenre) { create(:jenre) }
  let!(:jenre2) { create(:jenre) }
  let!(:style) { create(:style, user: user) }
  let!(:style2) { create(:style, user: user2) }
  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
  end
  describe 'style新規投稿' do
    context '動作の確認' do
      before do
        visit new_style_path
      end
      it '画像編集フォームが表示される' do
        expect(page).to have_field 'style[image]'
      end
      it '画像2編集フォームが表示される' do
        expect(page).to have_field 'style[image_second]'
      end
      it '画像3編集フォームが表示される' do
        expect(page).to have_field 'style[image_third]'
      end
      it 'name編集フォームが表示される' do
        expect(page).to have_field 'style[name]'
      end
      it 'content編集フォームが表示される' do
        expect(page).to have_field 'style[content]'
      end
      it 'price編集フォームが表示される' do
        expect(page).to have_field 'style[price]'
      end
      it 'status編集フォームが表示される' do
        expect(page).to have_field 'style[status]'
      end
      it 'menu編集フォームが表示される' do
        expect(page).to have_field 'style[menu]'
      end
      it 'color_style編集フォームが表示される' do
        expect(page).to have_field 'style[color_style]'
      end
      it '投稿に成功する' do
        fill_in 'style[name]', with: Faker::Lorem.characters(number:5)
        fill_in 'style[content]', with: Faker::Lorem.characters(number:20)
        fill_in 'style[price]', with: Faker::Number.number(digits: 6)
        fill_in 'style[menu]', with: Faker::Lorem.characters(number:5)
        fill_in 'style[color_style]', with: Faker::Lorem.characters(number:5)
        # fill_in 'style[status]', with: 0
        click_button '新規作成'
        expect(page).to have_content 'スタイルを登録'
        expect(page).to have_content '登録'
      end
      it '投稿に失敗する' do
        click_button '新規作成'
        expect(page).to have_content '入力してください'
      end
    end
  end
  describe 'style編集のテスト' do
    context '自分のstyle投稿の編集画面への遷移' do
      it '遷移できる' do
        visit edit_style_path(style)
        expect(current_path).to eq('/styles/' + style.id.to_s + '/edit')
      end
    end
    context '他人の投稿の編集画面への遷移' do
      it '遷移できない' do
        visit edit_style_path(style2)
        expect(current_path).to eq('/styles/' + style.id.to_s)
      end
    end
    context '表示の確認' do
      before do
        visit edit_style_path(style)
      end
      it '画像編集フォームが表示される' do
        expect(page).to have_field 'style[image]'
      end
      it '画像2編集フォームが表示される' do
        expect(page).to have_field 'style[image_second]'
      end
      it '画像3編集フォームが表示される' do
        expect(page).to have_field 'style[image_third]'
      end
      it 'name編集フォームが表示される' do
        expect(page).to have_field 'style[name]', with: style.name
      end
      it 'content編集フォームが表示される' do
        expect(page).to have_field 'style[content]', with: style.content
      end
      it 'price編集フォームが表示される' do
        expect(page).to have_field 'style[price]', with: style.price
      end
      it 'status編集フォームが表示される' do
        expect(page).to have_field 'style[status]', with: style.status
      end
      it 'menu編集フォームが表示される' do
        expect(page).to have_field 'style[menu]', with: style.menu
      end
      it 'color_style編集フォームが表示される' do
        expect(page).to have_field 'style[color_style]', with: style.color_style
      end
    end
    context 'フォームの確認' do
      it '編集に成功する' do
        visit edit_style_path(style)
        click_button '編集完了'
        expect(page).to have_content 'スタイルを更新'
        expect(current_path).to eq '/styles/' + style.id.to_s
      end
      it '編集に失敗する' do
        visit edit_style_path(style)
        fill_in 'style[name]', with: ''
        click_button '編集完了'
        expect(page).to have_content '入力してください'
      end
    end
  end

  describe 'style一覧画面のテスト' do
    before do
      visit styles_path
    end
    context '表示の確認' do
      it '自分と他人の画像のリンク先が正しい' do
        expect(page).to have_link '', href: style_path(style)
        expect(page).to have_link '', href: style_path(style2)
      end
    end
  end

  describe '詳細画面のテスト' do
    context '自分・他人共通の詳細画面の表示を確認' do
      it 'styleの名前が表示される' do
        visit style_path(style)
        expect(page).to have_content style.name
      end
      it 'styleの情報が表示される' do
        visit style_path(style)
        expect(page).to have_content style.status
      end
      it 'styleのPRが表示される' do
        visit style_path(style)
        expect(page).to have_content style.content
      end
      it 'styleのメニューが表示される' do
        visit style_path(style)
        expect(page).to have_content style.menu
      end
      it 'styleの値段が表示される' do
        visit style_path(style)
        expect(page).to have_content style.price
      end
      it 'styleのジャンル名が表示される' do
        visit style_path(style)
        expect(page).to have_content style.jenre.name
      end
      it 'styleのUSERのニックネームが表示される' do
        visit style_path(style)
        expect(page).to have_content style.user.nickname
      end
      it 'styleのUSERのPRが表示される' do
        visit style_path(style)
        expect(page).to have_content style.user.body
      end
    end
    context '自分のstyle詳細画面の表示を確認' do
      it 'styleの編集リンクが表示される' do
        visit style_path(style)
        expect(page).to have_link '編集する', href: edit_style_path(style)
      end
      it 'styleの削除リンクが表示される' do
        visit style_path(style)
        expect(page).to have_link '削除する', href: style_path(style)
      end
    end
    context '他人の投稿詳細画面の表示を確認' do
      it 'styleの編集リンクが表示されない' do
        visit style_path(style2)
        expect(page).to have_no_link '編集する', href: edit_style_path(style2)
      end
      it 'styleの削除リンクが表示されない' do
        visit style_path(style2)
        expect(page).to have_no_link '削除する', href: style_path(style2)
      end
    end
  end
end